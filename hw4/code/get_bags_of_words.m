%This feature representation is described in the handout, lecture
%materials, and Szeliski chapter 14.

function image_feats = get_bags_of_words(image_paths)
% image_paths is an N x 1 cell array of strings where each string is an
% image path on the file system.

% This function assumes that 'vocab.mat' exists and contains an N x feature vector length
% matrix 'vocab' where each row is a kmeans centroid or visual word. This
% matrix is saved to disk rather than passed in a parameter to avoid
% recomputing the vocabulary every run.

% image_feats is an N x d matrix, where d is the dimensionality of the
% feature representation. In this case, d will equal the number of clusters
% or equivalently the number of entries in each image's histogram
% ('vocab_size') below.

% You will want to construct feature descriptors here in the same way you
% did in build_vocabulary.m (except for possibly changing the sampling
% rate) and then assign each local feature to its nearest cluster center
% and build a histogram indicating how many times each cluster was used.
% Don't forget to normalize the histogram, or else a larger image with more
% feature descriptors will look very different from a smaller version of the same
% image.

load('vocab.mat')
size_v = size(vocab, 1);
N = size(image_paths, 1);
image_feats = zeros(N, size_v);
for i=1:N
    I1 = im2single(imread(image_paths{i}));
    SURF = detectSURFFeatures(I1);
    strongest = SURF.selectStrongest(200);
    [features,v] = extractHOGFeatures(I1,strongest,'CellSize',[48 48]);
    temp = zeros(size_v,1);
    index = knnsearch(vocab,features,'K',23);
    size_i=size(index,1);
    for j=1:size_i
        for k=1:10
            temp(index(j,k)) = temp(index(j,k)) +1;
        end
    end
    hist = temp./norm(temp);
    image_feats(i,:) = hist;
end






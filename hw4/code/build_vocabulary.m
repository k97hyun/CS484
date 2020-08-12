% This function will extract a set of feature descriptors from the training images,
% cluster them into a visual vocabulary with k-means,
% and then return the cluster centers.

% Notes:
% - To save computation time, we might consider sampling from the set of training images.
% - Per image, we could randomly sample descriptors, or densely sample descriptors,
% or even try extracting descriptors at interest points.
% - For dense sampling, we can set a stride or step side, e.g., extract a feature every 20 pixels.
% - Recommended first feature descriptor to try: HOG.

% Function inputs: 
% - 'image_paths': a N x 1 cell array of image paths.
% - 'vocab_size' the size of the vocabulary.

% Function outputs:
% - 'vocab' should be vocab_size x descriptor length. Each row is a cluster centroid / visual word.

function vocab = build_vocabulary( image_paths, vocab_size )

N1 = size(image_paths,1);
feat = [];
for i = 1:N1
    I1 = im2single(imread(image_paths{i}));
    SURF = detectSURFFeatures(I1);
    strongest = SURF.selectStrongest(200);
    [features,v] = extractHOGFeatures(I1,strongest,'CellSize',[48 48]);
    size_f = size(features,1);
    rand1 = randperm(size_f);
    sample = rand1(1:round(size_f/5));
    other = features(sample,:);
    feat = vertcat(feat,other);
end
[idx,C] = kmeans((feat),vocab_size);
vocab = C;


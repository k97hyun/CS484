% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Please implement the "nearest neighbor distance ratio test", 
% Equation 4.18 in Section 4.1.3 of Szeliski. 
% For extra credit you can implement spatial verification of matches.

%
% Please assign a confidence, else the evaluation function will not work.
%

% This function does not need to be symmetric (e.g., it can produce
% different numbers of matches depending on the order of the arguments).

% Input:
% 'features1' and 'features2' are the n x feature dimensionality matrices.
%
% Output:
% 'matches' is a k x 2 matrix, where k is the number of matches. The first
%   column is an index in features1, the second column is an index in features2. 
%
% 'confidences' is a k x 1 matrix with a real valued confidence for every match.

function [matches, confidences] = match_features(features1, features2)

% Placeholder random matches and confidences.
% num_features = min(size(features1, 1), size(features2,1));
% matches = zeros(num_features, 2);
% matches(:,1) = randperm(num_features); 
% matches(:,2) = randperm(num_features);
% confidences = rand(num_features,1);

threshold = 0.70;
[x1,y1] = size(features1);
[x2,y2] = size(features2);
dist = zeros(x1,x2);
for i = 1:x1
    for j =1:x2
        dist(i,j) = dot((features1(i,:) - features2(j,:)),(features1(i,:) - features2(j,:))).^(1/2);
    end
end

[s1,s2] = sort(dist,2);
NN1 = s1(:,1);
NN2 = s1(:,2);
confidences = NN1 ./ NN2;
i = find(confidences < threshold);
size_i = size(i);
matches = zeros(size_i(1),2);
matches(:,1) = i; 
matches(:,2) = s2(i);
confidences = 1./confidences(i);



% Sort the matches so that the most confident onces are at the top of the
% list. You should probably not delete this, so that the evaluation
% functions can be run on the top matches easily.
[confidences, ind] = sort(confidences, 'descend');
matches = matches(ind,:);


% Remember that the NNDR test will return a number close to 1 for 
% feature points with similar distances.
% Think about how confidence relates to NNDR.
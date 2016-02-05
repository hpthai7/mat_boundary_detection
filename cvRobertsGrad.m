function O = cvRobertsGrad(I, thresh)
% Description
%		Roberts Edge Detection with Gradient Combination
%
% Synopsis
%		O = cvRobertsGrad(I, [thresh])
%
% Inputs ([]s are optional)
%		(matrix) I        N x M x C matrix representing the input image
%		(scalar) [thresh = []]
%                     The sensitivity threshold. Ignores all edges
%                     that are not stronger than thresh. 
%                     If empty([]) is given, no thresholding. 
%                     Can be a 1 x C vector for a color image. 
%
% Outputs ([]s are optional)
%    (matrix) O       N x M x C matrix representing the output.
%
% Examples
%		I = cvuImread('lena.bmp');
%		S = cvRobertsGrad(I, 32);
%		figure; imshow(I);
%		figure; imshow(S);
%		S = cvRobertsGrad(I, []);
%		figure; imshow(S);
%
% Requirements
%		cvRoberts (requires conv2)
%
% Authors
%		Thai Ho
% Changes
%		22/11/2011 First Edition

if ~exist('thresh', 'var') || isempty(thresh)
    thresh = [];
end

O45 = cvRoberts(I, [], '45');
O135 = cvRoberts(I, [], '135');

[N, M, C] = size(I);
O = zeros(N, M, C);
O = abs(O45) + abs(O135);
O = uint8(cvuNormalize(O, [0, 255]));

% The threshold should be in [0, 255]
if ~isempty(thresh)
    if isscalar(thresh), thresh = repmat(thresh, 1, C); end;
    for c = 1:C
        O(:,:,c) = 255*(O(:,:,c) > thresh(c));
    end
end
end
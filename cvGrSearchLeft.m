function [idx, np, nq] = cvGrSearchLeft(Z, temp, p, q)
%
% Identifying a left-traversing horizontal edge
%
% Description: keep traveling along a horizontal edge until its direction changes
%
% Input:
%		Z [MxN]
%				token matrix used to obtain the dimension
%		temp [(2M-1)x(3N-3)]
%				temporary pseudo-image matrix
%		p & q [scalar]
%				position on matrix 'temp' from which we want to traverse left
% Output:
%		idx [MxN]
%				output image composed of {0, 1} representing the position of
%				the horizontal edge
%		np & nq [scalar]
%				pseudo-image matrix position at which the horizontal edge ends
%				or changes its direction (to vertical, sort of)

[M, N] = size(Z);
idx = zeros(M, N);

% left traversal position - the horizontal edge keeps extending
m0 = p+1; n0 = q-4;

% supposed-to-be ending position
ms = p+2; ns = q-3;

% Acknowledge lower points in the output image to be on the edge
% when the edge travels horizontally between two points (lower and upper)
while n0 >= 3 && temp(m0, n0) < temp(ms, ns) % && temp(m0, n0) < H - delta
% || temp(m0, n0) > 2H - delta
	idx((p+1)/2+1, (ns+1)/3+1) = 1;
	n0 = n0-3;
	ns = ns-3;
end

% ending point
idx((p+1)/2+1, (ns+1)/3+1) = 1;
np = p+2; nq = ns;
end
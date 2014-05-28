function [count,angle] = cpdh(object, angBins, radBins)
%Rotationally Invariant Contour Points Distribution Histogram
%function count = cpdh(object, angBins, radBins)
%
%OUTPUT
%   out = Contour Points Distribution Histogram
%
%INPUT
%   object = Binary image (logical type) containing the silloute or the contour of interest
%   angBins = number of angular bins
%   radBins = number of radial bins

%Detect number of objects in the image, select the biggest one only for
%computation

% TODO: remove all but largest component
% CC = bwconncomp(BW);

%       numPixels = cellfun(@numel,CC.PixelIdxList);
%       [biggest,idx] = max(numPixels);
%       BW(CC.PixelIdxList{idx}) = 0;

%Get the object boundary only
object = fastbwmorph(object, 'remove');
% object = fastbwmorph(object, 'clean');

stats = fastregionprops(object, 'Area','Orientation','PixelIdxList', 'BoundingBox');

% keyboard
if numel(stats) > 1
    maxIndx = 1;
    for i = 2:numel(stats)
        if stats(i).Area > stats(i-1).Area  
            maxIndx = i;
        end
    end
    stats = stats(maxIndx);
end

% imrotate cannot use logical for hardware acceleration
object = imrotate(uint8(object),-stats.Orientation);
object = logical(object);
stats = fastregionprops(object, 'BoundingBox', 'Area', 'PixelIdxList');
if numel(stats) > 1
    maxIndx = 1;
    for i = 2:numel(stats)
        if stats(i).Area > stats(i-1).Area  
            maxIndx = i;
        end
    end
    stats = stats(maxIndx);
    object = logical(zeros(size(object)));
    object(stats.PixelIdxList) = 1;
else
    object = logical(object);
end

% Get the object Only inside the image
object = object(ceil(stats.BoundingBox(2)):floor(stats.BoundingBox(2)+stats.BoundingBox(4)), ...
                ceil(stats.BoundingBox(1)):floor(stats.BoundingBox(1)+stats.BoundingBox(3)));

stats = fastregionprops(object,'Centroid','PixelList', 'Orientation');
angle = stats.Orientation;


if ~isempty(stats) && numel(stats.PixelList) > 2
    %Translate into polar coordinates
    centroid = stats.Centroid;
    cartesian = stats.PixelList;
    polar = zeros(size(cartesian));
    
    polar(:,1) = sqrt( (cartesian(:,1) - centroid(1)).^2 + (cartesian(:,2) - centroid(2)).^2 );
    polar(:,2) = atan2( cartesian(:,2) - centroid(2) , cartesian(:,1) - centroid(1) );
    
    %Spatial Partitions
    maxRo = max(polar(:,1));
    radii = maxRo/radBins;
    angles = 2*pi/angBins;
    
    count = hist3(polar,{0+radii/2:radii:maxRo-radii/2  -pi+angles/2:angles:pi-angles/2});
    
    %%%%PLOT HISTOGRAM%%%%
    %figure, bar3(count); xlabel('angles'); ylabel('radii');
    %%%%%%%%%%%%%%%%%%%%%%
    
    count = reshape(count, radBins*angBins,1);
    count = count/norm(count,2); %normalization
else
    count = zeros(radBins*angBins, 1);
end



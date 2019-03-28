function scsnl_searchlight_qin(VY, VM, SearchOpt, SummaryFunction, OutputFile)

if isempty(SearchOpt)
  SearchOpt.def = 'sphere';
  SearchOpt.spec = 6;
end

VY = char(VY);
VY = spm_vol(VY);

VM = char(VM);
VM = spm_vol(VM);

%-Get space details
%--------------------------------------------------------------------------
N            = length(VY);                     %-number of images
M            = VY(1).mat;                          %-voxels to mm matrix
iM           = inv(M);                             %-mm to voxels matrix
DIM          = VY(1).dim;                          %-image dimensions
NDIM         = prod([DIM N]);                      %-overall dimension
[x,y,z]      = ndgrid(1:DIM(1), 1:DIM(2), 1:DIM(3));
XYZ          = [x(:)';y(:)';z(:)']; clear x y z    %-voxel coordinates {vx}
XYZmm        = M(1:3, :)*[XYZ; ones(1, size(XYZ,2))];%-voxel coordinates {mm}
XYZmm_cpy    = XYZmm;                              %-copy without masking

YY = spm_read_vols(VY);

%-Search volume (from mask)
%--------------------------------------------------------------------------
if ~isempty(VM)
  if any(DIM-VM.dim) || any(any(abs(VM.mat-M)>1e-4))
    MM   = spm_get_data(VM,VM.mat\[XYZmm;ones(1,size(XYZmm,2))],false);
  else
    MM   = spm_read_vols(VM);
  end
  MM       = logical(MM);
  %XYZmm    = XYZmm(:,MM(:));
  XYZ      = XYZ(:, MM(:));
else
  error('MaskFile not found');
end

%-Searchlight options (clique definition)
%--------------------------------------------------------------------------
xY     = SearchOpt;
xY.xyz = [NaN NaN NaN];
xY.rej = {'cluster','mask'};
xY     = spm_ROI(xY);

%-Get local clique and perform searchlight over voxels
%==========================================================================

%-Build local clique
%--------------------------------------------------------------------------
c            = round(DIM(:)/2);
xY.xyz       = M(1:3,:) * [c;1];
[~, clique] = spm_ROI(xY, XYZmm_cpy);
clique       = round(iM(1:3,:) * [clique;ones(1,size(clique,2))]);
clique       = bsxfun(@minus, clique, c);

SLR  = zeros(size(XYZ, 2), 1);

%-Searchlight
%--------------------------------------------------------------------------
for i = 1:size(XYZ,2)
  
  %-Local clique (handle image boundaries and mask)
  %----------------------------------------------------------------------
  xyz          = bsxfun(@plus,XYZ(:,i),clique);
  xyz(:,any(bsxfun(@lt,xyz,[1 1 1]') | bsxfun(@gt,xyz,DIM'))) = [];
  idx          = sub2ind(DIM,xyz(1,:),xyz(2,:),xyz(3,:));
  j            = MM(idx);
  idx          = idx(j);
  %xyz          = xyz(:,j);
  idx      = bsxfun(@plus, idx(:), 0:prod(DIM):NDIM-1);
  Y        = YY(idx);
  
  
  %-Call user-specified function
  %----------------------------------------------------------------------
  
  switch lower(SummaryFunction)
    case 'pearson_correlation'
      SLR(i) = corr(Y(:,1), Y(:,2));
  end
end

%-Write out images
%-Corr
%fprintf('......Writing out ...\n');
MV   = NaN(DIM);
MV(sub2ind(DIM,XYZ(1,:),XYZ(2,:),XYZ(3,:))) = SLR;
VO = deal(struct(...
  'fname',   [],...
  'dim',     DIM,...
  'dt',      [spm_type('float64') spm_platform('bigend')],...
  'mat',     M,...
  'pinfo',   [1 0 0]',...
  'descrip', 'Searchlight_Result'));

 VO.fname = [OutputFile, '_corr.nii'];
 spm_write_vol(VO, MV);

%-Z score
MV   = NaN(DIM);
MV(sub2ind(DIM,XYZ(1,:),XYZ(2,:),XYZ(3,:))) = 0.5*log((1+SLR)./(1-SLR));
VO = deal(struct(...
  'fname',   [],...
  'dim',     DIM,...
  'dt',      [spm_type('float64') spm_platform('bigend')],...
  'mat',     M,...
  'pinfo',   [1 0 0]',...
  'descrip', 'Searchlight_Result'));

VO.fname = [OutputFile, '_zscore.nii'];
spm_write_vol(VO, MV);

end

function [Y,Xf,Af] = testMatcherTrackletJoinerANN(X,~,~)
%TESTMATCHERTRACKLETJOINERANN neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 17-Jul-2014 17:00:39.
% 
% [Y] = testMatcherTrackletJoinerANN(X,~,~) takes these arguments:
% 
%   X = 1xTS cell, 1 inputs over TS timsteps
%   Each X{1,ts} = 103xQ matrix, input #1 at timestep ts.
% 
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = 1xQ matrix, output #1 at timestep ts.
% 
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

  % ===== NEURAL NETWORK CONSTANTS =====
  
  % Input 1
  x1_step1_remove = [2 14 15 16 22 23 24 30 31 32 33 38 43 48 53 58 73 78 83 88 100];
  x1_step1_keep = [1 3 4 5 6 7 8 9 10 11 12 13 17 18 19 20 21 25 26 27 28 29 34 35 36 37 39 40 41 42 44 45 46 47 49 50 51 52 54 55 56 57 59 60 61 62 63 64 65 66 67 68 69 70 71 72 74 75 76 77 79 80 81 82 84 85 86 87 89 90 91 92 93 94 95 96 97 98 99 101 102 103];
  x1_step2_xoffset = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;3.59722835128196e-05;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];
  x1_step2_gain = [0.0136054421768707;2.90652540942163;2.03594339769179;2.22453971037998;2.2661917770324;2.66934324134796;3.82592962655991;5.52634296895388;8.92691135544028;21.2014145573032;21.3158949357296;149.211258625831;2.15238198726946;3.23195131002918;2.89185261997406;20.0758560709365;110.326792142022;2.16176805791407;2.53657463776784;2.11370854694141;8.15287624578416;100.697570935707;13.8082107673563;6.90410538367816;4.82182539825101;4.38853737271326;8.95823650438382;6.58280605906989;5.34373974790435;6.26276490399498;12.4365055700217;7.03562333417449;5.09501548573835;6.89347525784972;10.4642249520557;6.49999975785614;5.14241607225711;7.44983228435196;14.7648223857065;6.24499828680726;4.72941282264113;6.65732687383463;16.0277532493858;6.90410538367816;4.5981361714041;4.58257560677817;43.3589677406016;13.8082107673563;7.45117477070123;5.19025768043141;4.87339729252091;43.3589677406016;12.020815295909;7.46190306544748;5.30690742346193;7.03562333417449;10.8397419351504;6.51152815179889;5.93158261916995;9.91071258210701;12.4365055700217;5.42627363533498;5.25873755877293;6.19677356028073;12.3648250792599;6.05530078327738;5.16397764900917;6.892024659714;11.4891250363589;6.21825278501086;4.83045882217874;4.39851552995242;2;2;2;2;2;2;2;0.03125;0.00470588235294118;0.00680272108843537];
  x1_step2_ymin = -1;
  
  % Layer 1
  b1 = [0.015572983710236187882;0.1570031566380868937;-3.3131582642039556497;0.17466740770689903606];
  IW1_1 = [-0.064542514195565031665 -0.022946629326363824491 -0.015361990055489514739 0.05274795678358745743 -0.10774168822527392664 -0.084859540820496084934 -0.14492878690131408281 -0.19614513612734849057 -0.15578423865118337655 -0.13104407833140635509 0.013801067258423178885 -0.063571190818913228537 -0.09809057866470588527 -0.051804016754025614122 -0.14031391419783781349 -0.18336985124913302014 -0.037701509866752837274 -0.078615682287956414886 -0.00038975105106887176316 -0.11057611881607906645 -0.014641590559086942874 -0.087645891642431514312 -0.047265401653657085346 -0.051316689563131442919 -0.023888851834456999168 -0.065856175427256691268 -0.052354099678058138578 -0.057787349746105283466 -0.03930432177487080958 -0.1038776809168042714 -0.0084336291649565898326 -0.034217385403991121273 -0.097915013561335070835 -0.014953103954172517615 -0.048958321767564212668 -0.043811117334478205665 0.032763265952657313895 -0.064630369158855824341 -0.10543353299012950264 0.017244271477021275163 -0.042945675026381892325 -0.06853039733381166565 -0.064129735689385500286 -0.01331997474640090641 -0.052503576750134853257 -0.088570320329349264132 -0.038272101013140963355 0.0043907878033956288313 -0.005187179942042179602 -0.13291432743662817684 -0.038738151410660823237 -0.023206295302015397114 -0.10068750918603273925 -0.020555250251369550779 -0.063013351230970959804 -0.065282273570104812355 -0.061221861550660200413 0.0037799581750523731337 -0.018647093036135778399 -0.038093421400141179445 -0.077726146182756070124 -0.020798332587515948322 -0.018398763184041676266 -0.052485010756802001619 -0.076641869510537502519 0.023597751752713086448 -0.036417272461026800601 -0.052390371671919080954 -0.043076961334441637996 -0.056873582883453233094 -0.075209293274852595523 -0.040452105934868233528 0.042504575014679461809 0.05705455458728524859 0.044091503601382350808 -0.061808248010720052978 -0.18534074626612950798 -0.12931325367127682879 -0.045375593516611294198 -0.1756242243180407836 -0.33293165788228951119 -0.26786562835719024411;-0.083450209629817126422 -0.089893466325624962754 0.088644469715556784006 -0.03217577374901531978 0.017747932807352637119 -0.0092841424115269240852 -0.055946046467264629043 -0.10212303742405975937 -0.12433473366730138365 -0.12955399802004211041 -0.12646079988317873721 -0.10491347070014329923 0.019023011354038527054 -0.038238325400644326835 -0.052316957602855720944 -0.12634275432568298214 -0.18928214498399970056 0.002220674789028414392 -0.12689416690665192289 -0.047293434059204227105 -0.14000919413866280694 -0.20570646042170287471 -0.13200095970964598191 -0.045134725481428217275 -0.078334879068044122041 -0.048147470157119807987 -0.11829031524957177302 -0.047456499252887904272 -0.062742702075929954186 -0.096549585574055130088 -0.074702974782663397746 -0.052142852499077671502 -0.051304594665560407374 -0.089781222497553464512 -0.07680046213508134878 -0.069152939696348683651 -0.046142585193922391884 -0.10648801650375439021 -0.070210199938739462078 -0.051893731227214259794 -0.062441314584240945051 -0.081740449606128473548 -0.082648198879426093555 -0.030911911253815045619 -0.081199175213730351297 -0.045377886279014005566 -0.13292814212404108209 -0.086180078770879894878 -0.019238150325684304914 -0.081899287324975228453 -0.057455724711267669447 -0.15256414285068889414 -0.076549514150371505972 -0.033072470985387708575 -0.061659058149732048904 -0.07444409115007510902 -0.084670798375809666614 -0.046402220420655115873 -0.032334921261467752807 -0.088403896924204639074 -0.089772519255428132046 -0.059811557257195391291 -0.054057895769727762336 -0.095749125068449125742 -0.073567986482224692613 -0.065042484120194490882 -0.079683013324566870361 -0.058740241508119572789 -0.11734788912706758945 -0.061295318784665417389 -0.072958933411898241328 -0.062430283346610500328 -0.11202479754620246755 -0.042373567833198629018 -0.1207707678208614771 -0.13349381426598760925 -0.098439086406308537458 -0.060631627274817280482 -0.072515187135850769917 -0.028715052120318270562 -5.5266255011227733394e-05 -0.0169053838364397295;0.047992808425635108405 0.44635302684915295623 -0.092773736194823597234 -0.11483751619416805723 0.18798916576092081221 -0.40841263224267548848 0.27203593114040108825 -0.33236509165669808619 -0.012063136427104496212 0.30250654511666713598 0.30873544594444879419 -0.387954163912248573 0.023299307601055793682 0.047153965582520981914 -0.1535981771137676366 0.010312227191984789376 0.1650618758205442127 -0.48408513282023651891 0.28611483006592702827 0.098577561694105059198 0.33659407866032442502 -0.090994483250079166714 0.188247980089150585 -0.062575081211788952107 0.11377454058494387845 0.12706256123593900886 -0.1890914494394860812 -0.022899198933396987254 0.18902722240657834907 -0.025611189418079591262 0.061091015309760784979 0.022850054822668455778 -0.019514236829575034443 0.035746737503294066796 -0.02842993866260566313 0.013157698645197734438 0.018691753870597089399 0.015892716655311930896 0.037365358812144158773 -0.013573674369268108261 -0.047764781285843535552 0.053884800794135268021 0.081197597372432636642 -0.19429546172371389701 0.091426709018335342027 0.023428235881832973342 0.10517709589727053388 -0.32745024565000802053 0.055168424212894952297 0.024115129437702290116 0.14230390643099194437 0.31814301953836299219 0.071703086599669271783 -0.075596863716055812121 0.06420269054222486893 0.014029353789114937939 0.0074058208256356401755 0.012644516850427913596 -0.030681331935541514971 0.10622675341167495122 0.04607675872688968971 0.080521212365612646056 -0.13796996021902280249 0.041857874348963021449 -0.036360966225558809251 0.026984499002508596094 -0.10289583642906514893 0.047223180376223701515 0.14130369578025778199 0.015060218140295495923 -0.070574128497133445381 -0.0082458640320153524933 0.086707409490493908555 0.061749967677175998659 0.049979984481388378681 0.064067225004893868512 0.071380337067036767063 -0.015861254643697142441 -0.042218234683476456304 -0.7387797952604425733 -1.6904463336768584814 -3.229835382088031448;-0.10026584578265894387 -0.093605923941827776091 0.091471240368063769233 -0.029738788255051940013 0.011442210123836175223 -0.0097251518383048591448 -0.068596527693379358293 -0.11882757854287283317 -0.13775496988719709845 -0.14393349789126258509 -0.14233244655206095386 -0.12026330853357644624 0.018466733289126704282 -0.037828666311790659638 -0.06354666277062336055 -0.14539867229473307786 -0.20881645063912507299 0.0048025993283636906825 -0.13068668436246411169 -0.051748373254197212179 -0.15517295487755031203 -0.22039638140082709605 -0.15353112479549221869 -0.058950102302318743708 -0.095808001388626690131 -0.065418014614134767371 -0.13048015737668028358 -0.055850040519602676958 -0.072675179735924980151 -0.10132096612403017344 -0.089619105573151683353 -0.059294058907629405841 -0.073605616243563418144 -0.10104682511673826473 -0.095844517592347563961 -0.070467112131643333539 -0.052796802743927860602 -0.12278644841895174078 -0.083973095244625026168 -0.050442330166043936046 -0.069795506493182210561 -0.087688850395576098395 -0.11012442449556976432 -0.033117264458006327732 -0.089989108717431390283 -0.061477115751192190629 -0.15342882472917793168 -0.10701989425163567493 -0.027489333357237515088 -0.096697671226478584816 -0.073290502857281725202 -0.15858448651236783933 -0.096311089233275165578 -0.040657311418686295501 -0.067843554853495316448 -0.094466358751004106398 -0.082871793158155196424 -0.047588588477303843394 -0.034603062123593375521 -0.098921907884249038467 -0.10045515976679164627 -0.060976495357387611174 -0.061114378026944964073 -0.10350819249144813106 -0.087258312746093871781 -0.060911939573577808527 -0.094107323503804504727 -0.072675762985470807043 -0.1305761325367994774 -0.070000738575920137818 -0.080719693746424611702 -0.065471403127735958161 -0.12656501860377858404 -0.047064792295862085958 -0.12979620106972750149 -0.14915401759324412034 -0.12319062264325085498 -0.066902094204836962121 -0.080084148141721656078 -0.035156480273379288326 -0.016702652423348240268 -0.022180243311284826568];
  
  % Layer 2
  b2 = -0.73791174325595809691;
  LW2_1 = [-0.2795754975020668387 -0.59603060031585064493 6.1559219589575153719 -0.60945368518140463632];
  
  % Output 1
  y1_step1_ymin = -1;
  y1_step1_gain = 2;
  y1_step1_xoffset = 0;
  
  % ===== SIMULATION ========
  
  % Format Input Arguments
  isCellX = iscell(X);
  if ~isCellX, X = {X}; end;
  
  % Dimensions
  TS = size(X,2); % timesteps
  if ~isempty(X)
    Q = size(X{1},2); % samples/series
  else
    Q = 0;
  end
  
  % Allocate Outputs
  Y = cell(1,TS);
  
  % Time loop
  for ts=1:TS
  
    % Input 1
    temp = removeconstantrows_apply(X{1,ts},x1_step1_keep,x1_step1_remove);
    Xp1 = mapminmax_apply(temp,x1_step2_gain,x1_step2_xoffset,x1_step2_ymin);
    
    % Layer 1
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*Xp1);
    
    % Layer 2
    a2 = logsig_apply(repmat(b2,1,Q) + LW2_1*a1);
    
    % Output 1
    Y{1,ts} = mapminmax_reverse(a2,y1_step1_gain,y1_step1_xoffset,y1_step1_ymin);
  end
  
  % Final Delay States
  Xf = cell(1,0);
  Af = cell(2,0);
  
  % Format Output Arguments
  if ~isCellX, Y = cell2mat(Y); end
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings_gain,settings_xoffset,settings_ymin)
  y = bsxfun(@minus,x,settings_xoffset);
  y = bsxfun(@times,y,settings_gain);
  y = bsxfun(@plus,y,settings_ymin);
end

% Remove Constants Input Processing Function
function y = removeconstantrows_apply(x,settings_keep,settings_remove)
  if isempty(settings_remove)
    y = x;
  else
    y = x(settings_keep,:);
  end
end

% Sigmoid Positive Transfer Function
function a = logsig_apply(n)
  a = 1 ./ (1 + exp(-n));
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n)
  a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings_gain,settings_xoffset,settings_ymin)
  x = bsxfun(@minus,y,settings_ymin);
  x = bsxfun(@rdivide,x,settings_gain);
  x = bsxfun(@plus,x,settings_xoffset);
end

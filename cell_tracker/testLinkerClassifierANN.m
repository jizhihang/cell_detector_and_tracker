function [Y,Xf,Af] = testLinkerClassifierANN(X,~,~)
%TESTLINKERCLASSIFIERANN neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 29-Jul-2014 14:44:08.
% 
% [Y] = testLinkerClassifierANN(X,~,~) takes these arguments:
% 
%   X = 1xTS cell, 1 inputs over TS timsteps
%   Each X{1,ts} = 108xQ matrix, input #1 at timestep ts.
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
  x1_step1_keep = [1 3 4 5 6 7 8 9 10 11 12 13 17 18 19 20 21 25 26 27 28 29 34 35 36 37 39 40 41 42 44 45 46 47 49 50 51 52 54 55 56 57 59 60 61 62 63 64 65 66 67 68 69 70 71 72 74 75 76 77 79 80 81 82 84 85 86 87 89 90 91 92 93 94 95 96 97 98 99 101 102 103 104 105 106 107 108];
  x1_step2_xoffset = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;3.59722835128196e-05;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;-4.09213972091675;-17;-10.777777671814];
  x1_step2_gain = [0.0136054421768707;2.90652540942163;2.03594339769179;2.22453971037998;2.2661917770324;2.66934324134796;3.82592962655991;5.52634296895388;8.92691135544028;21.2014145573032;21.3158949357296;149.211258625831;2.15238198726946;3.23195131002918;2.89185261997406;20.0758560709365;110.326792142022;2.16176805791407;2.53657463776784;2.11370854694141;8.15287624578416;100.697570935707;13.8082107673563;6.90410538367816;4.82182539825101;4.38853737271326;8.95823650438382;6.58280605906989;5.34373974790435;6.26276490399498;12.4365055700217;7.03562333417449;5.09501548573835;6.89347525784972;10.4642249520557;6.49999975785614;5.14241607225711;7.44983228435196;14.7648223857065;6.24499828680726;4.72941282264113;6.65732687383463;16.0277532493858;6.90410538367816;4.5981361714041;4.58257560677817;43.3589677406016;13.8082107673563;7.45117477070123;5.19025768043141;4.87339729252091;43.3589677406016;12.020815295909;7.46190306544748;5.30690742346193;7.03562333417449;10.8397419351504;6.51152815179889;5.93158261916995;9.91071258210701;12.4365055700217;5.42627363533498;5.25873755877293;6.19677356028073;12.3648250792599;6.05530078327738;5.16397764900917;6.892024659714;11.4891250363589;6.21825278501086;4.83045882217874;4.39851552995242;2;2;2;2;2;2;2;0.03125;0.00470588235294118;0.00680272108843537;6.13019461510209e-11;2.67695246890572e-10;0.287677045906678;0.0671641793434804;0.106824927932146];
  x1_step2_ymin = -1;
  
  % Layer 1
  b1 = [-0.15550214630254999282;-1.860269854848208837;-0.39870639909549282498];
  IW1_1 = [0.093198043318316201034 0.055529066372353733105 -0.024308692341915891233 0.023288709541727601465 0.03404856178541619538 0.051100945309499788693 0.07178100687721633566 0.090518355025109353829 0.11714471812410574836 0.12451868534707730141 0.097944822826058125509 0.10582895378638762507 0.0069835174229721311279 0.027058920307344698497 0.06496696358889442191 0.10526009040459113897 0.1431640469306655894 0.0042873975553386952514 0.084716842594601646232 0.067535763954472555204 0.094555663745350279625 0.1230017981624698109 0.11082280940966504623 0.034939923731871005974 0.07153889183815005659 0.066681436672767158136 0.11909327712190370674 0.037382531544051571248 0.077351279327159849775 0.11017226625394582751 0.082172308866068646815 0.042957029818327489845 0.06836555375685768321 0.089820495835422828335 0.05723554590910039791 0.079855825210624870047 0.063141896012518516912 0.093508496026099757747 0.10750337179118524267 0.036559726094016115061 0.063848310875423863742 0.10709222282732352993 0.096498059514061040876 0.018229997016599282234 0.06735051477157877331 0.082300934633969716203 0.09749327076781783008 0.056917057259723402574 0.025143378022330090116 0.08927943633104357124 0.061725569718395933982 0.10593255285409772237 0.069932872109066540611 0.044596897908927263243 0.065755447619135862225 0.09954756463892644458 0.068531872650976405348 0.052158180143532281714 0.040800355787692102472 0.082311521272081453193 0.087525467668194870119 0.058230661557361104719 0.059000386852288193296 0.11523620329992198541 0.080864819740169208151 0.039915795500107584259 0.064150857264950539305 0.05967077962884762693 0.10022195951620693766 0.044410246512475118341 0.035770164728729625381 0.058150291867118640565 0.13823282586180687947 0.079787289449633994054 0.042596834972124686391 0.14691408379638293269 0.076080041283470484226 0.014178639313386733056 0.061907785150853100742 0.029786326646159856646 0.039618143491822715996 0.047008504031142150925 0.15357509169988606268 0.1545435528378831247 -0.023902365136814079233 -0.03479779216487700888 -0.034566294619378802599;1.2536982372864917679 1.2404896040266115698 1.6566677723485061513 0.73229656666108167151 1.5747401348235843255 1.8798521668158265641 2.5918875160181982231 3.0478131934483316812 2.8458848487368619828 2.7950672787089629878 2.5466105482509866498 3.1047090951164313388 1.8607107002631477766 1.5120944025453737503 2.4099403628093689633 2.2553318035194114266 1.4562409202697734756 2.0225835393488402758 1.0465737139170963044 2.1087723294613716085 2.1312378444639619168 1.2372485865755207257 2.1377650952196312062 0.99035173397322429079 0.98645821251744436609 1.3319674970663555325 1.5017767960052186282 0.63691734009609635159 1.0582867154882400484 0.85845043646155128059 1.4409910683686459887 0.56713586840014063029 0.75365598738727090922 0.19984494081680492794 1.3149313467295595803 0.53274593789677004985 1.1422989258571620841 0.90120541880673898927 2.0977251627360695707 1.1518543001344114796 1.5324825389063132519 0.76262605403976047036 1.9122935207459219598 1.3693002932224112023 0.7890804855290198816 1.0333450595448294695 1.6368785600586359674 1.7614569274090188244 1.4932729036566017022 1.1708098921887579724 0.63718538405539559832 1.751458250674596151 1.5539328808826047279 1.2782828638530379095 1.7290029267558855164 1.1757067458926060421 2.2469870616043583489 1.4190714497392342697 1.1394312755028417339 0.015149608699641325948 2.051554967813237873 1.3638351823993040135 0.86944262428162411016 0.86378346732828537036 2.1088431407981382826 1.0211221839100215192 1.4999076370648911638 1.0306125942544874796 1.5719671370590251325 2.1308129581147476905 0.91754474146341857832 1.4902585712954681263 0.31485496642702653913 2.0901971848270797238 0.47386332851504409103 1.5247750797748604867 1.6054432713657487142 2.3865130569923058701 1.8190000912990260673 1.816868955475179126 2.4062246620832805633 1.9058215222089918139 2.7632013955359564505 2.044438942967309103 -0.11348530048466856646 -0.14282390600089611699 -0.25086026532388555621;0.20519774799167428414 0.24205903054665106611 -0.32349019320910815667 -0.038621373738162739775 -0.11164158960635969797 0.022550900938243790411 0.17563617055470162609 0.28107675439011442498 0.32215920046464940896 0.33635915609920352676 0.33898164267335900712 0.29962893547721797249 -0.089349584803421311374 0.047584873267015381781 0.17707646725425063572 0.36701721826382294189 0.37343681188647864788 -0.057516483035482991737 0.27840799699519253041 0.14161288851857389837 0.34756228017727286428 0.3650167586587509394 0.3773816904029008712 0.099685586075436691256 0.20383011786098778617 0.19090497652194413081 0.29114966748199638813 0.075650633701930633523 0.092239476412274118422 0.26122162047350200309 0.14565345428268150485 0.054443654071551848828 0.17469343897402370147 0.18718641365823487921 0.15857927024529416826 0.19266354909549190944 0.094542892242670803493 0.23863362968219117843 0.29269833492944019593 0.14278813908402293587 0.1962381450456357479 0.19328315508766324982 0.2911454614917551309 0.13262709660847118998 0.26644025630313017405 0.2301984303695530365 0.37009255424601827933 0.32952250487207301877 0.072134383364003420991 0.24161414061055572211 0.15940720514282410991 0.40656171379044864223 0.26812550948965940822 0.090388761923638705209 0.17021140464574285867 0.2243158291128214965 0.23873072068646275512 0.20029863817848655994 0.13046765523449860291 0.24540066160813900353 0.17848367018843688814 0.19297163519851504021 0.13292708080070531063 0.23729720675342894087 0.16937367713343157161 0.14781552577317499941 0.1764786136231775715 0.21743519525747756482 0.27487928219912510786 0.13694343642271045169 0.21110833263520242808 0.125927185042473605 0.44557499170415704182 -0.006201036180758009303 0.10097631874093088156 0.36156870207232266745 0.25752887057581408392 0.028861536564491464124 0.063644615816642241546 9.0185481855698318367e-05 -0.13742987673617121369 -0.11144655854123118599 0.33389029617740456635 0.38108925807883820003 -0.11943028930830847101 -0.10966706800429142088 -0.18012322556870943857];
  
  % Layer 2
  b2 = -6.4246907023010937365;
  LW2_1 = [6.277104395409393689 7.2864238709794042492 5.626533818860817604];
  
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

function [Y,Xf,Af] = testLinkerClassifierANN(X,~,~)
%TESTLINKERCLASSIFIERANN neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 19-Jul-2014 23:44:35.
% 
% [Y] = testLinkerClassifierANN(X,~,~) takes these arguments:
% 
%   X = 1xTS cell, 1 inputs over TS timsteps
%   Each X{1,ts} = 114xQ matrix, input #1 at timestep ts.
% 
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = 1xQ matrix, output #1 at timestep ts.
% 
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

  % ===== NEURAL NETWORK CONSTANTS =====
  
  % Input 1
  x1_step1_remove = [2 14 15 16 22 23 24 30 31 32 33 38 43 48 53 58 73 78 83 88 100 109 110];
  x1_step1_keep = [1 3 4 5 6 7 8 9 10 11 12 13 17 18 19 20 21 25 26 27 28 29 34 35 36 37 39 40 41 42 44 45 46 47 49 50 51 52 54 55 56 57 59 60 61 62 63 64 65 66 67 68 69 70 71 72 74 75 76 77 79 80 81 82 84 85 86 87 89 90 91 92 93 94 95 96 97 98 99 101 102 103 104 105 106 107 108 111 112 113 114];
  x1_step2_xoffset = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;3.59722835128196e-05;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;46;41;-4.09213972091675;-17;-10.777777671814;-8.87482929229736;-7.72759056091309];
  x1_step2_gain = [0.0136054421768707;2.90652540942163;2.03594339769179;2.22453971037998;2.2661917770324;2.66934324134796;3.82592962655991;5.52634296895388;8.92691135544028;21.2014145573032;21.3158949357296;149.211258625831;2.15238198726946;3.23195131002918;2.89185261997406;20.0758560709365;110.326792142022;2.16176805791407;2.53657463776784;2.11370854694141;8.15287624578416;100.697570935707;13.8082107673563;6.90410538367816;4.82182539825101;4.38853737271326;8.95823650438382;6.58280605906989;5.34373974790435;6.26276490399498;12.4365055700217;7.03562333417449;5.09501548573835;6.89347525784972;10.4642249520557;6.49999975785614;5.14241607225711;7.44983228435196;14.7648223857065;6.24499828680726;4.72941282264113;6.65732687383463;16.0277532493858;6.90410538367816;4.5981361714041;4.58257560677817;43.3589677406016;13.8082107673563;7.45117477070123;5.19025768043141;4.87339729252091;43.3589677406016;12.020815295909;7.46190306544748;5.30690742346193;7.03562333417449;10.8397419351504;6.51152815179889;5.93158261916995;9.91071258210701;12.4365055700217;5.42627363533498;5.25873755877293;6.19677356028073;12.3648250792599;6.05530078327738;5.16397764900917;6.892024659714;11.4891250363589;6.21825278501086;4.83045882217874;4.39851552995242;2;2;2;2;2;2;2;0.03125;0.00470588235294118;0.00680272108843537;6.13019461510209e-11;2.67695246890572e-10;0.0111111111111111;0.0109289617486339;0.287677045906678;0.0671641793434804;0.106824927932146;0.104754715156509;0.144580290122724];
  x1_step2_ymin = -1;
  
  % Layer 1
  b1 = [-0.38854017060392104232;1.2157112527488900255;-0.1173000532902533366;-0.14111804831283467077];
  IW1_1 = [0.23025097968197683063 0.14494793902159117116 0.24989352616982885014 -0.029783543079951176752 0.20486540881503609302 0.22976320091732690964 0.21270448596410856945 0.16829393160806721541 0.24676841246843073119 0.27656239946148603037 0.24577422962573203247 0.25670718472670406296 0.13617854543572005532 0.067790027809508948686 0.17135630304259052981 0.22027773596592589711 0.29844941242621220168 0.097171183009193334845 0.12052189776305666236 0.18500176804841214628 0.19350480860197585842 0.15891521809945360899 0.2888023427856823977 0.15270965082605506002 0.20708212446863530354 0.20183264426642161249 0.205663492024609873 0.12919839925954337834 0.18064519514261045963 0.083601054938288260621 0.28800261628077300502 0.12643218059168873091 0.11196256121711710418 0.24679223447854825579 0.12419443285202461102 0.23439192732004726638 0.22908069840488518021 0.15707004434131383031 0.23153815064289520742 0.17852927832115317308 0.16858846535041827064 0.2508254475698888375 0.14921575263351335994 0.1713568539620798914 0.186683715459145666 0.10770968570170012801 0.19473005064473802861 0.059176152560166270233 0.17795596299978616583 0.15608612924685710821 0.13530193224021092036 0.22162131089774284032 0.14024121934642597154 0.080950000035779498542 0.11505915760221528676 0.059731334751148515427 0.10775909018166270059 0.061259720365852685098 0.095765716708849146777 0.27240847905170423315 0.26257006624175655007 0.25019540993485861469 0.15794612088179019183 0.21474806469666649078 0.23310524812368196845 0.14356293581852322405 0.22676897535145404405 0.13175908740822986354 0.27571267462633114453 0.14906478675944334622 0.14652791686516192238 0.17428998168425319237 0.2754389167288759932 0.075907149550259650495 0.22973167657033702338 0.32740171632058528983 0.19786630206531591325 0.090302688284082305303 0.25877868913719243027 0.0232527553292760647 -0.035228790113083580104 -0.082140985597571894439 0.38253171890081122397 0.40744982478491920119 0.053433707003991290363 0.35147498988105496665 -0.11054819848012305272 -0.1111720754292301605 -0.077632879489079820168 -0.047657753415741570258 -0.11545090682170343344;0.039297725250134619979 -0.23212708622511601941 0.1193765148008355953 0.11405183690325219892 -0.24198030967329500762 0.10187381737983300378 -0.035461981433643839645 0.098389848707890928403 -0.39529768881620341858 -0.11120287327470108896 0.03189420036851360607 -0.048450145689599752319 0.12073875864650564227 -0.06634249110682284567 0.18932200992639605652 0.10954162339340631216 -0.11611076347665770514 0.25679600618157555347 -0.3712321453793050452 0.052106003479984022708 -0.098604902015316311936 0.0089841552039919454764 -0.17417903737754519833 0.075454627257663609008 -0.054262849670133492253 0.011113980079865297401 0.38234408794272300991 -0.0011321011298580821273 -0.15915671913261034143 0.023022888759665183223 -0.11315663350931440267 0.040332485763427253223 -0.11661588236656346418 0.00094277483781552654657 0.013609676176068815148 -0.020170507513631433238 -0.030493862813460274885 0.063031738195584802176 0.03784931318804150846 -0.01594411713015942561 0.055928751704006351986 0.037317846266198134719 -0.1409454080025860645 0.065933806966653490944 -0.00056477527388248678457 0.028258023131383452897 -0.28111090716918296639 0.12233573544858014626 0.04902921856799015432 -0.021384996695610062473 -0.05596457621730450277 0.22230109079025797691 0.037953996488854606361 0.098835063307161505342 0.020973737735197593018 -0.0030301092706499928829 0.01507180755824223499 -0.02359777267107507695 -0.015155332544107358653 -0.059581613619263021353 -0.038795382949243908954 -0.035264355359206668583 0.035251353717441605284 -0.023725566993863102944 0.071036662862518307193 -0.022839859657690923106 0.096831624358458587287 -0.024366767401237748869 0.008863131504074564862 -0.016527831308518165648 0.12815770429436201816 -0.018653544380989948992 -0.0058363236384203201132 -0.041565208752852494944 -0.10214351948890187938 -0.098625454664207301558 0.1405965452738896504 -0.033120778112472055998 0.036329642485054554346 1.2323950144212285629 2.1381645318255575461 2.930027061964078694 -1.4210145638870250728 -1.5329792302413918215 0.49407796548179877538 -1.551940710188059791 0.28816039712472113488 1.1535452428574539674 0.074194253391344805459 0.23906024173708600999 0.56009294588978253415;0.07732509192973216483 0.028812453477711538752 0.14041035988028030546 -0.010136144886359685011 0.10877388447712380004 0.13500414449509670622 0.13308548531325617437 0.1256393280652631228 0.12711363580471096713 0.12924840919597971323 0.12234335600990126069 0.13875490002440499238 0.081129458422639286197 0.031708525127818631972 0.12138301008706403605 0.11768743578413505546 0.10905553544136534216 0.054895127344032672301 0.02720314830718093338 0.10814197951711626566 0.099642394761812649873 0.076665831975109260954 0.098606948790332757393 0.068146143173038159491 0.074315175894843293891 0.083284421741894237856 0.068423774785620589123 0.0391807083317385757 0.049057665332489210075 0.018475056222733557409 0.10174547309631157277 0.044260160103764725759 0.040194933577439133365 0.054535001183789670598 0.060194520811330302912 0.065996282281330878594 0.068972754718581358313 0.048125754975911871902 0.083606022385189229795 0.04728383272094567602 0.042035600182138942171 0.072297399791274655212 0.071812352065801970946 0.067757593341109340068 0.053119704595776931488 0.050665446442778074021 0.035457572098367508284 0.045306127851941345452 0.08260116720067335605 0.062848210975175802795 0.065032147422515257373 0.030396580174548278042 0.061644526236099367322 0.036659735533113059491 0.019574916974406948722 0.036341727297621730097 0.0098265160524161777184 0.019833537357826939995 0.045061261021729519249 0.055767529110361313549 0.089961874694028956534 0.071052655907802048096 0.05767740741108478425 0.044784370038683476989 0.097503160547655939872 0.017799200887709368951 0.092924710204999275143 0.049106510741295052169 0.075464762187223130563 0.053589452614228108573 0.05536633693924578048 0.053586947476058674478 0.10180440631835634135 0.049369601918465781665 0.035119509494340749034 0.07160253388293974508 0.092885126023001196582 0.075512730023318125339 0.059176978586714445996 0.037902063136190135284 0.033840694290126316357 0.015058772602723567019 0.14720773391193839319 0.12872293021262662394 0.00033779777829729144747 0.07607105842374832505 -0.029130791871808146137 -0.024401515528486492773 -0.028192366983745581477 0.017131362573732565602 -0.00085363472240034660686;0.14469868905881339005 0.17023636242416259612 -0.0083187803781104678602 0.18098180806298849732 0.11588329157983351392 0.20812712534838298528 0.43522936076363266666 0.63794919248525905342 0.48645889055007407453 0.39612743167930891675 0.4125607355056326031 0.41715476491221403776 0.17650589455464937849 0.28792379896123082572 0.32112013706966241466 0.51874561866083235273 0.62656441149197972251 0.18164687656799843873 0.24223509974926768495 0.22494312264000509982 0.52323981193236179799 1.0614666972616308982 0.25815720903875966075 0.16273309991717660461 0.14046188392421515845 0.090993754377982766224 0.050745698353612395115 -0.011062013452818300965 0.09841650188302515645 0.26973109105656151163 -0.048826673721310623333 -0.071683025105774969554 0.058576385777768052998 -0.10763129029063057962 0.11763057735848049534 0.060153661130679221547 -0.039945826643254710164 0.24746574204332066893 0.20331612334134382958 0.10171857999176306397 0.20835593371692978648 0.10185503643285701014 0.1056255621126964972 0.13804743659289381297 0.14124599673227483665 0.17614375118582661917 0.5510969340300381214 0.38829628544951916291 0.022849626514601907579 0.23250004816291444665 0.14197207261815328327 0.55228038944760882156 0.38906351957551632559 0.055595807455162689348 0.15131044940769458607 0.40122585062170090797 0.64375478256873119864 0.24730513365008915949 0.15283659637773419626 -0.080715113956608561252 0.24507538884799354162 0.088199833894073903506 0.17048157100239300088 0.011038074074853033643 0.17906564378093137169 0.066413633698871252231 0.059054966428331183426 0.21622063677968178519 0.056017869171600051525 0.17914542860771567878 0.22117601473409614909 0.17484395278889330871 -0.10626368471811667438 0.29282408496829276379 0.2764348112634800736 0.15150395656525730836 0.050658695596917539816 0.46542735038024213301 0.09236126254023270532 0.27643982321558235871 0.37439539949022104803 0.51564231661540549378 0.15095379552544338497 0.14524758230655665514 -0.28742091315183909694 -0.38659200977352281559 0.013021259755746222853 0.019496483150549512309 0.067017926289499193948 0.14460243838851274956 0.12716461484803467941];
  
  % Layer 2
  b2 = -0.54410264320443180175;
  LW2_1 = [0.2882882347251177757 -7.0412532343176117422 0.49664326566706118449 0.50303030529272740878];
  
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

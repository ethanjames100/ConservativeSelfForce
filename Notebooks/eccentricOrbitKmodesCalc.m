(* ::Package:: *)

LaunchKernels[64];
<<SpinWeightedSpheroidalHarmonics`
<<KerrGeodesics`
<<GeneralRelativityTensors`
<<Teukolsky`
ParallelNeeds["SpinWeightedSpheroidalHarmonics`"]
ParallelNeeds["KerrGeodesics`"]
ParallelNeeds["GeneralRelativityTensors`"]
ParallelNeeds["Teukolsky`"]
prec=40;
\[Alpha]string=Import["C:\\Users\\SMP22EJG\\Documents\\GitHub\\ConservativeSelfForce\\Notebooks\\TPPM\\TPPMStringTable..a0..p20..e0.3..LMAX15..NMAX50.dat"];
\[Alpha]s =Uncompress[\[Alpha]string[[1,1]]];
\[Alpha][s_,l_,m_,n_]:=Uncompress[\[Alpha]s[[If[s==-1,1,2], l,m +l+1,n+51]]];
\[GothicS][sp_,l_,lp_, m_]:= -sp  Sqrt[(2(2l+1))/(2 lp +1)]ClebschGordan[{l,m},{1,0},{lp,m}] ClebschGordan[{l,-sp} ,{1,sp }, {lp ,0}]
Ccoef[s_,j_,k_,m_,bs_]:=\[GothicS][s,j,k,m]*(j/.bs);
CLcoef [a_,m_,n_,j_,k_,\[Omega]_, bs_]:=(j/.bs)*(Sqrt[j(j+1)] KroneckerDelta[j,k] - a \[Omega] \[GothicS][+1, j,k,m]);
Off[ClebschGordan::tri ]
Off[ClebschGordan::phy]
ParallelEvaluate[Off[ClebschGordan::tri ]]
ParallelEvaluate[Off[ClebschGordan::phy]]
Fr0[a_,\[Tau]_,  orbit_, k_,m_,n_, LMAX_]:= Module[{A,B,t, r,\[Theta],\[CurlyPhi],K0,\[CapitalSigma],\[CapitalDelta]},
{t,r,\[Theta],\[CurlyPhi]}=orbit["Trajectory"];
\[CapitalDelta]=r[\[Tau]]^2-2 M r[\[Tau]] + a^2/.M->1;
\[CapitalSigma]=r[\[Tau]]^2+ a^2 Cos[\[Theta][\[Tau]]]^2;
K0= \[Omega][m,n]((r[\[Tau]])^2 + a^2)- a m;

Sum[Module[{bsplus,bsminus,\[Chi], g, dP,\[CapitalBeta],Pminus, Pplus,Rminus, \[Lambda], cl, cp, cm, \[ScriptCapitalD]P},
bsplus = SpinWeightedSpheroidalHarmonicS[1,l,m,N[a \[Omega][m,n]],Method->{"SphericalExpansion","NumTerms"->LMAX+1}]["ExpansionCoefficients"] ;
bsminus = SpinWeightedSpheroidalHarmonicS[-1,l,m,N[a \[Omega][m,n]],Method->{"SphericalExpansion","NumTerms"->LMAX+1}]["ExpansionCoefficients"] ;
cl =CLcoef[a, m, n ,j,k,\[Omega][m,n],bsplus];
cp = Ccoef[1, j, k, m , bsplus];
cm = Ccoef[-1, j,k,m, bsminus];

If[cl ==0&&cp==0&&cl==0,0,
\[Lambda] = SpinWeightedSpheroidalEigenvalue[-1,l,m,a \[Omega][m,n]];
\[CapitalBeta]= Sqrt[\[Lambda]^2 + 4 a m \[Omega][m,n] - 4 a^2 \[Omega][m,n]^2];

Pminus= 2\[Alpha][-1,l,m,n]["ExtendedHomogeneous"->"\[ScriptCapitalH]"][r[\[Tau]]];
Pplus = \[CapitalDelta] \[Alpha][+1,l,m,n]["ExtendedHomogeneous"->"\[ScriptCapitalH]"][r[\[Tau]]];
dP =2\[Alpha][-1,l,m,n]["ExtendedHomogeneous"->"\[ScriptCapitalH]"]'[r[\[Tau]]] ;
\[ScriptCapitalD]P =dP - I K0/\[CapitalDelta] Pminus; 
g= 1/\[CapitalBeta] (r[\[Tau]]\[ScriptCapitalD]P-Pminus);
\[Chi]=Exp[-I *\[Omega][m,n]*t[\[Tau]] + I *m *\[CurlyPhi][\[Tau]]];

A = Re[\[Chi](cl g + I a cp/\[CapitalBeta] \[ScriptCapitalD]P)];
B=- Im[\[Chi](cm Pminus - cp*Pplus)];
tmp=(Sqrt[2] (t'[\[Tau]] - a \[CurlyPhi]'[\[Tau]]))/(r[\[Tau]]^2 \[CapitalSigma]) A + (\[CurlyPhi]'[\[Tau]] *(a^2+r[\[Tau]]^2) + a t'[\[Tau]])/(Sqrt[2] \[CapitalDelta] r[\[Tau]] \[CapitalSigma]) B;
tmp
]
],{l,Max[1,Abs[m]],LMAX}, {j, k-1, k+1}]
]
AbsoluteTiming[Module[{t,r,\[CapitalEpsilon],L,\[Theta],\[CurlyPhi], const,a=SetPrecision[0,prec], e=SetPrecision[0.3,prec],p=SetPrecision[20,prec],x=1, \[Tau]=0.5,LMAX= 15,NMax=30},
q=1;
orbit = KerrGeoOrbit[a,p,e,x]; 
{t,r,\[Theta],\[CurlyPhi]}=orbit["Trajectory"];
\[CapitalOmega] =KerrGeoFrequencies[a,p,e,x];
const=KerrGeoConstantsOfMotion[a,p,e,x];
\[CapitalEpsilon]=const[[1]];
L = const[[2]];
\[Omega][m_,n_]:=m \[CapitalOmega][[3]] + n \[CapitalOmega][[1]];
kmodes =ParallelTable[Sum[Fr0[a,\[Tau],  orbit,k ,m,n, LMAX]SpinWeightedSphericalHarmonicY[0,k,m,\[Theta][\[Tau]],0], {m,-k,k}, {n,-NMax, NMax}],{k,1,kmax}]
]]

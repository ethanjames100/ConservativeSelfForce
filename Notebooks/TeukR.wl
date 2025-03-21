(* ::Package:: *)

mypath="/users/smp22ejg/bhptk/"
myfiles={mypath<>"Teukolsky",mypath<>"KerrGeodesics",mypath<>"GeneralRelativityTensors", mypath<>"SpinWeightedSpheroidalHarmonics"}
Print["Launched"];
ParallelEvaluate[PacletDirectoryLoad[myfiles]]
PacletDirectoryLoad[myfiles]
<<Teukolsky`
<<KerrGeodesics`
ParallelNeeds["Teukolsky`"]
ParallelNeeds["KerrGeodesics`"]


(*Configurable*)
prec = 40;
a= 0;
p=20;
e=0;
LMAX=20;
NMAX=10;
dir = "/users/smp22ejg/conservativeSelfForce/TRadial/";

(*Set Precisions*)
aa = SetPrecision[a,prec];
pp = SetPrecision[p,prec];
ee = SetPrecision[e,prec];
x = 1;

rmin = p/(1+e+0.1);
rmax = p/(1-e-0.1);


data = Table[ParallelTable[Module[{R},
	(*Calculate Teukolsky Mode*)
	R = TeukolskyRadial[s,l,m,aa, \[Omega][m,n]];
	Print[ToString[{s,l,l,m,n}]<>" Completed"];
	(*compress and save to table*)
	Compress[R]
], {l,1,LMAX},{m,-l,l},{n,-NMAX,NMAX}],{s,{-1,1}} ];
dataString = Compress[data];
Export[dir<>"TRadialStringTable..a"<>ToString[a]<>"..p"<>ToString[p]<>"..e"<>ToString[e]<>"..LMAX"<>ToString[LMAX]<>"..NMAX"<>ToString[NMAX]<>".dat",dataString]

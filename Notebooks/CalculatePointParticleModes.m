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

Print[Information[PacletObject["Teukolsky"]]]

Package
(*Configurable*)
prec = 40;
a= 0;
p=20;
e=0.1;
LMAX=30;
NMAX=30;
dir = "/users/smp22ejg/conservativeSelfForce/TPPM/";

(*Set Precisions*)
aa = SetPrecision[a,prec];
pp = SetPrecision[p,prec];
ee = SetPrecision[e,prec];
x = 1;

(*Calculate Orbits*)
orbit = KerrGeoOrbit[aa, pp, ee, x];

(*Calculate table of interpolation strings*)
data = Table[ParallelTable[Module[{mode, rs, interp},
	(*Calculate Teukolsky Mode*)
	mode = TeukolskyPointParticleMode[s,l,m,n,0,orbit];
	Print[{s,l,m,n}];
	Compress[mode]
], {l,1,LMAX}, {m,-l,l},{n,-NMAX,NMAX}],{s,{-1,1}} ];

dataString = Compress[data];
Export[dir<>"TPPMStringTable..a"<>ToString[a]<>"..p"<>ToString[p]<>"..e"<>ToString[e]<>"..LMAX"<>ToString[LMAX]<>"..NMAX"<>ToString[NMAX]<>".dat",dataString]

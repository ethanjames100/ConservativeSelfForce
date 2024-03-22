(* ::Package:: *)

LaunchKernels[64];
<<Teukolsky`
<<KerrGeodesics`
ParallelNeeds["Teukolsky`"]
ParallelNeeds["KerrGeodesics`"]

(*Configurable*)
prec = 40;
a= 0;
p=10;
e=0.1;
ra = 4;
rb = 100;
dr = 1;
region = "\[ScriptCapitalH]";
LMAX=30;
NMAX=30;
dir = "";

(*Set Precisions*)
aa = SetPrecision[a,prec];
pp = SetPrecision[p,prec];
ee = SetPrecision[e,prec];
x = 1;

(*Calculate Orbits*)
orbit = KerrGeoOrbit[aa, pp, ee, x];

(*Calculate table of interpolation strings*)
data = ParallelTable[Module[{mode, rs, interp},
	(*Calculate Teukolsky Mode*)
	mode = TeukolskyPointParticleMode[s,l,m,n,0,orbit];
	(*calculate table of values through specified domain*)
	rs = Table[{r,mode["ExtendedHomogeneous"->region][r]},{r,ra,rb,dr}];
	(*interpolate rvalues*)
	interp = Interpolation[rs];
	Print[ToString[{s,l,m,n}]<>" Completed"];
	(*compress and save to table*)
	Compress[interp]
],{s,{-1,1}}, {l,1,LMAX}, {m,-l,l},{n,-NMAX, NMAX} ];

dataString = Compress[data];
Export[dir<>"TPPMStringTable..a"<>ToString[a]<>"..p"<>ToString[p]<>"..e"<>ToString[e]<>"..ra"<>ToString[ra]<>"..rb"<>ToString[rb]<>"..region"<>region<>"..LMAX"<>ToString[LMAX]<>"..NMAX"<>ToString[NMAX]<>".dat",dataString]

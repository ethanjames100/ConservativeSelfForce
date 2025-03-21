# ConservativeSelfForce

This project aims to calculate the Conservative Electromagnetic Self-force for eccentric orbits in Kerr Geometry.

## Directories
- Tex Contians a Tex Doccument with all the notes made on the calculation
- Notebooks Contains all the Mathematica notebooks written in the calculatin

## Notebooks
- **SchwarzchildEccentricSelfForce.nb**: Calculates the self force at a point in the orbit for a particle in an eccentric orbit about a schwarzchild black hole
- **KerrCircularSelfForce.nb**: Calculates the self force at a point in the orbit for a particle in circular orbit about a Kerr Black Hole
- **SchwarzchildCircularSelfForce.nb**: Calculates the self force at apoint in the orbit for a particle 
- **deriving r component equation.nb**: Calculations for deriving eqn 29
- **TheoCode.nb**: Theo's code for calculating the self-force in the scwarzchild circular regime.
- **TaylorExpandingInCos.nb**: Calculations for taylor expansion in eq 44
- **RadialComponent.nb**: Initial calcualtions done for calculating the self force along the trajectory.
- **testingEthanCodeInSCaseAgainstTheo.nb**: code that tests my code agains theo's.
- **EccentricOrbitRegularisation.nb**: Investagiative calculations
- **testingCL**: Testing the calculation of the CL function.
- **CalculatePointParticleModes.m**: Calculates Point particle modes (meant for HPC use)

## TPPM files
The files referanced in some of these notebooks contain computed Teukolsky point particle mode objects (i.e. the output of TeukolskyPointParticleMode[s,l,m,n,0,orbit]). These files are available on request but as they are too large for github.

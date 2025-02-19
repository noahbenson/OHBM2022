#!/usr/bin/env wolframscript

<<Neurotica`


sdataPath="/data/nyuretinotopy_morph/surface_data";
fsPath="/data/freesurfer/subjects/fsaverage/surf";


ClearAll[MeshTranslate,MeshRotate];
MeshTranslate[mesh_?CorticalMeshQ,{dx_,dy_,dz_}]:=CorticalMesh[mesh,VertexCoordinates->Transpose[{dx,dy,dz}+VertexCoordinatesTr[mesh]]];
MeshRotate[mesh_?CorticalMeshQ,args__]:=With[{mtx=RotationMatrix[args],x0=VertexCoordinatesTr[mesh]},CorticalMesh[mesh,VertexCoordinates->Transpose[mtx . x0]]];


ClearAll[AngleColor,EccenColor,AngleColorFn,EccenColorFn];
AngleColor[ang_]:=Blend[{Darker@Red,Lighter@Yellow,Darker@Green,Lighter@Cyan,Darker@Blue,Lighter@Magenta,Darker@Red},Mod[-(ang+180)/360,1]];
EccenColor[ecc_]:=Blend[{{0,Darker@Blue},{2.5,Lighter@Magenta},{5,Darker@Red},{10,Lighter@Yellow},{20,Darker@Green},{40,Lighter@Cyan},{90,Darker@Gray}},ecc];
AngleColorFn[alpha_:1]:=Function@With[{v=#cod},If[NumericQ[v]&&v>0.1&&NumericQ[#ang],Blend[{CorticalCurvatureColor[#Curvature],AngleColor[#ang]},alpha],"Curvature"]];
EccenColorFn[alpha_:1]:=Function@With[{v=#cod},If[NumericQ[v]&&v>0.1&&NumericQ[#ecc],Blend[{CorticalCurvatureColor[#Curvature],EccenColor[#ecc]},alpha],"Curvature"]];


lh=Import[
FileNameJoin[{fsPath,"lh.white"}],
"FreeSurferSurface"];
lh=MeshTranslate[MeshRotate[lh,{{1,0,0},{1,-1,0}}],{-50,20,0}];
rh=Import[
FileNameJoin[{fsPath,"rh.white"}],
"FreeSurferSurface"];
rh=MeshTranslate[MeshRotate[rh,{{1,0,0},{1,1,0}}],{50,20,0}];


subjects=Map[
Last@*FileNameSplit,
FileNames@FileNameJoin[{sdataPath,"*"}]];


ClearAll[LoadHemi];
LoadHemi[sub_,h_]:=With[
{hs=ToLowerCase@ToString[h]},
With[
{data=AssociationMap[
Function@With[
{x=Import[
FileNameJoin[{sdataPath,sub,hs<>"."<>#<>".mgz"}],
{"GZIP","MGH","Frames"},
"SanityChecks"->False]},
If[Length[x]==1,x[[1]],x]],
{"xyz","ang","ecc","cod","crv"}]},
With[
{tr=Last@FindGeometricTransform[
VertexCoordinates@If[h===LH,lh,rh],
data["xyz"],
TransformationClass->"Rigid"]},
SetVertexProperties[
CorticalMesh[
If[h===LH,lh,rh],
VertexCoordinates->tr@data["xyz"]],
Join[
Normal[data],
With[
{tht=Pi/180*(90-data["ang"]),ecc=data["ecc"]},
{"x"->ecc*Cos[tht],
"y"->ecc*Sin[tht],
"Curvature"->data["crv"]}]]]]]];


ClearAll[BlendHemi,CosTr];
BlendHemi[h1_,h2_,w_]:=SetVertexProperties[
CorticalMesh[
h1,
VertexCoordinates->Plus[
(1-w)*VertexCoordinates[h1],
w*VertexCoordinates[h2]]],
With[
{dat=Map[
#->((1-w)*(#/.h1)+w*(#/.h2))&,
<|"x","y","cod","crv","Curvature","xyz"|>]},
Join[
Normal[dat],
{"ang"->(Mod[90-180/Pi*ArcTan[dat["x"],dat["y"]]+180,360]-180),
"ecc"->Sqrt[dat["x"]^2+dat["y"]^2]}]]];
CosTr[x_]:=Piecewise[{{0,x<0.25},{1,x>0.75}},(1-Cos[Pi*2*(x-0.25)])/2];


$OutputPath="/data/nyuretinotopy_morph/frames";
$DPI=144;$BaseOptions=Sequence[PlotRange->{{-400,400},{-400,400},{-400,400}},BoxRatios->{1,1,1},ImageSize->{1600,900},ViewAngle->7 Degree,ViewCenter->{0.5,0.5,0.5},SphericalRegion->False,
ViewPoint->{0,-2,0},ViewVertical->{0,0,1}];
$ColorFn=AngleColorFn[];


FramePlot[lhem_,rhem_]:=Show[
{CortexPlot3D[lhem,ColorFunction->$ColorFn],
CortexPlot3D[rhem,ColorFunction->$ColorFn]},
Sequence@$BaseOptions]


ClearAll[RenderFrames,Render1Frame];
$FrameRate=30;
$ChangeDuration=2;
$FramesPerStep=$FrameRate*$ChangeDuration;
Render1Frame[lh1_, lh2_, rh1_, rh2_, f_, frame0_] := With[
   {t = CosTr@N[f/($FramesPerStep - 1)]},
   With[
    {flnm = StringJoin[
       "/data/nyuretinotopy_morph/frames/frame",
       IntegerString[
        Which[t == 0, 0, t == 1, $FramesPerStep - 1, True, f] + frame0,
        10, 5],
       ".png"]},
    If[! FileExistsQ[flnm],
     Export[
      flnm,
      FramePlot[
       BlendHemi[lh1, lh2, t], BlendHemi[rh1, rh2, t]],
      "PNG",
      ImageResolution -> $DPI],
     flnm]]];
RenderFrames[s1_,s2_,frame0_:0]:=With[
{lh1=LoadHemi[s1,LH],rh1=LoadHemi[s1,RH],
lh2=LoadHemi[s2,LH],rh2=LoadHemi[s2,RH]},
Table[
Render1Frame[lh1,lh2,rh1,rh2,f,frame0],
{f,Range[0,$FramesPerStep-1]}]]


jobs=Transpose@List[
subjects,RotateLeft[subjects],
$FramesPerStep*Range[0,Length[subjects]-1]];


RenderFrame[fr_]:=With[
{job=SelectFirst[jobs,#[[3]]<=fr&&fr<=#[[3]]+$FramesPerStep&]},
With[
{s1=job[[1]],s2=job[[2]],frame0=job[[3]]},
With[
{lh1=LoadHemi[s1,LH],rh1=LoadHemi[s1,RH],
lh2=LoadHemi[s2,LH],rh2=LoadHemi[s2,RH]},
Render1Frame[lh1,lh2,rh1,rh2,fr-frame0,frame0]]]];


n=ToExpression@Last[$ScriptCommandLine];
ii=ToExpression[$ScriptCommandLine[[-2]]];
Scan[Apply[RenderFrames,#]&,jobs[[ii;;All;;n]]];

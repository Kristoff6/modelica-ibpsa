within Annex60.Fluid.Examples.Performance;
model Example4
  extends Modelica.Icons.Example;

  Fluid.MixingVolumes.MixingVolumeMoistAir vol(
    nPorts=2,
    ports(m_flow(min={0,-Modelica.Constants.inf})),
    redeclare package Medium = Medium,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal=1,
    V=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{0,16},{20,36}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    dp1_nominal=0,
    dp2_nominal=0,
    allowFlowReversal1=allowFlowReversal,
    allowFlowReversal2=allowFlowReversal)
    annotation (Placement(transformation(extent={{-20,20},{-40,0}})));
  Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    p=Medium.p_default + 1000,
    use_p_in=false,
    use_T_in=true,
    X={0.02,0.98},
    nPorts=2) annotation (Placement(transformation(extent={{-70,-4},{-50,16}})));
  Fluid.Sources.MassFlowSource_T source(
    redeclare package Medium = Medium,
    m_flow=1,
    T=273.15,
    nPorts=1) annotation (Placement(transformation(extent={{20,14},{0,-6}})));
  package Medium = Annex60.Media.Air;

  Real m_condens;
  Fluid.Sources.Boundary_pT sink(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{78,6},{58,26}})));
  Modelica.Blocks.Sources.RealExpression mCond(y=m_condens)
    annotation (Placement(transformation(extent={{-40,40},{-20,20}})));
  Utilities.Psychrometrics.X_pTphi xSat(use_p_in=false)
    annotation (Placement(transformation(extent={{30,52},{50,32}})));
  Modelica.Blocks.Sources.Constant phiSat(k=1)
    annotation (Placement(transformation(extent={{-28,40},{-12,56}})));
  Modelica.Blocks.Sources.Ramp Tin(
    duration=1,
    height=20,
    offset=293.15)
    annotation (Placement(transformation(extent={{-52,30},{-72,50}})));
  Fluid.FixedResistances.FixedResistanceDpM res(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dp_nominal=100,
    allowFlowReversal=allowFlowReversal,
    from_dp=true)
    annotation (Placement(transformation(extent={{30,6},{50,26}})));
  parameter Boolean allowFlowReversal=false
    "= true to allow flow reversal in medium 1, false restricts to design direction (port_a -> port_b)";
  Fluid.Sensors.TemperatureTwoPort senTem(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=1,
    tau=0) annotation (Placement(transformation(extent={{-16,10},{-4,22}})));
equation

  m_condens=min(0, -vol.ports[1].m_flow*(bou.X[1] - xSat.X[1]));
  connect(phiSat.y, xSat.phi) annotation (Line(
      points={{-11.2,48},{28,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mCond.y, vol.mWat_flow) annotation (Line(
      points={{-19,30},{-16,30},{-16,34},{-2,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Tin.y, bou.T_in) annotation (Line(
      points={{-73,40},{-80,40},{-80,10},{-72,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(res.port_b,sink. ports[1]) annotation (Line(
      points={{50,16},{58,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.port_b, vol.ports[1]) annotation (Line(
      points={{-4,16},{8,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senTem.T, vol.TWat) annotation (Line(
      points={{-10,22.6},{-10,30.8},{-2,30.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senTem.T, xSat.T) annotation (Line(
      points={{-10,22.6},{-10,42},{28,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(vol.ports[2], res.port_a) annotation (Line(
      points={{12,16},{30,16}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_a1, source.ports[1]) annotation (Line(
      points={{-20,4},{0,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_a2, bou.ports[1]) annotation (Line(
      points={{-40,16},{-46,16},{-46,8},{-50,8}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_b1, bou.ports[2]) annotation (Line(
      points={{-40,4},{-50,4}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hex.port_b2, senTem.port_a) annotation (Line(
      points={{-20,16},{-16,16}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-20},
            {80,60}}),         graphics), Icon(coordinateSystem(extent={{-100,-100},
            {100,100}}, preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
July 14, 2015, by Michael Wetter:<br/>
Revised documentation.
</li>
<li>
April 17, 2015, by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This example generates a non-linear algebraic loop 
that consists of <i>12</i> equations before manipulation. 
This loop can be decoupled and removed by changing the equation 
</p>
<pre>
port_a.m_flow + port_b.m_flow = -mWat_flow;
</pre>
<p>
in
<a href=\"modelica://Annex60.Fluid.Interfaces.StaticTwoPortConservationEquation\">
Annex60.Fluid.Interfaces.StaticTwoPortConservationEquation</a>
to
</p>
<pre>
port_a.m_flow + port_b.m_flow = 0;
</pre>
</html>"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/Examples/Performance/Example4.mos"
        "Simulate and plot"));
end Example4;
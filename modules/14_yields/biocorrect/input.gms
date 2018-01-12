*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

$setglobal c14_yields_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

scalars
  s14_yld_past_switch  switch determing the effectivity of translating crop tc into pasture yield increase       / 1 /
;

******* Calibration factor
table f14_yld_calib(i,ltype14) Calibration factor for the LPJ yields ()
$ondelim
$include "./modules/14_yields/input/f14_yld_calib.csv"
$offdelim;

table f14_yields(t_all,j,kve,w) LPJ potential yields per cell (rainfed and irrigated) [ton dry matter per ha]
$ondelim
$include "./modules/14_yields/input/lpj_yields.cs3"
$offdelim
;
* set values to 1995 if nocc scenario is used
$if "%c14_yields_scenario%" == "nocc" f14_yields(t_all,j,kve,w) = f14_yields("y1995",j,kve,w);
m_fillmissingyears(f14_yields,"j,kve,w");

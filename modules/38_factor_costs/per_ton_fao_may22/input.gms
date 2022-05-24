*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



parameter f38_fac_req(kcr) Factor requirement costs in 2005 (USD05MER per tDM)
/
$ondelim
$include "./modules/38_factor_costs/input/f38_fac_req_fao.csv"
$offdelim
/
;

parameter f38_fac_req_fao_reg(i,kcr) Factor requirement costs in 2005 (USD05MER per tDM)
/
$ondelim
$include "./modules/38_factor_costs/input/f38_fac_req_fao_regional.cs4"
$offdelim
/
;


parameter f38_reg_parameters(reg) Parameters for regression
/
$ondelim
$include "./modules/38_factor_costs/input/f38_regression_cap_share.csv"
$offdelim
/
;

table f38_historical_share(t_all,i) Historical capital share
$ondelim
$include "./modules/38_factor_costs/input/f38_historical_share.csv"
$offdelim
;

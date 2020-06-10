*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Fixing variables
v73_prod_natveg.fx(j,"other",ac_sub,"wood") = 0;
v73_prod_natveg.fx(j,"primforest",ac_sub,kforestry)$(not sameas(ac_sub,"acx")) = 0;
** Set lower bound to positive variable
vm_land_fore.lo(j,"plant",ac) = 0;

** Set historical values to FAO values
p73_forestry_demand_prod_specific(t_past,iso,total_wood_products) = f73_prod_specific_timber(t_past,iso,total_wood_products);

** Loop over time to calculate future demand
** Calculations based on Lauri et al. 2019
loop(t_all$(m_year(t_all) >= 2010 AND m_year(t_all) < 2150),
   p73_forestry_demand_prod_specific(t_all+1,iso,total_wood_products)
          = p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)
          *
          (im_pop_iso(t_all+1,iso)/im_pop_iso(t_all,iso))$(im_pop_iso(t_all,iso)>0)
          *
          ((im_gdp_pc_ppp_iso(t_all+1,iso)/im_gdp_pc_ppp_iso(t_all,iso))**f73_income_elasticity(total_wood_products))$(im_gdp_pc_ppp_iso(t_all,iso)>0)
          ;
);
p73_forestry_demand_prod_specific(t_all,iso,total_wood_products)$(im_gdp_pc_ppp_iso(t_all,iso)=0) = 0.0001;

p73_timber_demand_gdp_pop(t_all,i,kforestry) = sum((i_to_iso(i,iso),kforestry_to_woodprod(kforestry,total_wood_products)),p73_forestry_demand_prod_specific(t_all,iso,total_wood_products));

** Woodfuel fix
** We only model 50% of woodfuel demand. Similar assumption to IMAGE
** This can be done according to development stage of regions as well but the results are buggy.
p73_timber_demand_gdp_pop(t_all,i,"woodfuel") = p73_timber_demand_gdp_pop(t_all,i,"woodfuel") * 0.5;
*p73_timber_demand_gdp_pop(t_all,i,"woodfuel")$(im_development_state(t_all,i)<1) = p73_timber_demand_gdp_pop(t_all,i,"woodfuel") * 0.5;

* m3 to ton conversion.
* 0.6 ton DM / m^3
* conversion factor of roundwood  : 632.5 kg/m3 (mean value) as in FAO Document (http://www.fao.org/3/a-i4441e.pdf), Page 6, table 4.
* Conversion factor of wood fuel  : 307.1 kg/m3 (mean value) as in FAO Document (http://www.fao.org/3/a-i4441e.pdf), Page 7, table 6.
p73_volumetric_conversion("wood") = 0.6;
p73_volumetric_conversion("woodfuel") = 0.3;

* p73_timber_demand_gdp_pop in in mio m^3
* pm_demand_ext in mio ton DM
pm_demand_ext(t_ext,i,kforestry) = round(p73_timber_demand_gdp_pop("y2150",i,kforestry) * p73_volumetric_conversion(kforestry),3);
pm_demand_ext(t_all,i,kforestry) = round(p73_timber_demand_gdp_pop(t_all,i,kforestry) * p73_volumetric_conversion(kforestry),3);
p73_demand_ext_original(t_ext,i,kforestry) = pm_demand_ext(t_ext,i,kforestry);

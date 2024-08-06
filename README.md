# PhillyFrbAsDataframe

Up to date remote economic data access for ruby, using Polars dataframes. 

This package will fetch economic and financial information from the Federal Reserve Bank of Philadelphia, and return the results as a Polars dataframe.  For details regarding the data available from the Philadelphia FRB, see https://www.philadelphiafed.org/surveys-and-data .  This gem exposes the Partisan Conflict Index (see https://www.philadelphiafed.org/surveys-and-data/macroeconomic-data/partisan-conflict-index) and the Survey of Professional Forecasters (see https://www.philadelphiafed.org/-/media/frbp/assets/surveys-and-data/survey-of-professional-forecasters/spf-documentation.pdf).


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'philly_frb_as_dataframe'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install philly_frb_as_dataframe

## Usage

```{ruby}
3.1.2 :001 > PhillyFrbAsDataframe::PartisanConflict.new.fetch
 => 
shape: (522, 2)                                                               
┌────────────┬───────────────────┐                                            
│ Timestamps ┆ Partisan Conflict │                                            
│ ---        ┆ ---               │                                            
│ date       ┆ f64               │                                            
╞════════════╪═══════════════════╡                                            
│ 1981-01-01 ┆ 68.944808         │                                            
│ 1981-02-01 ┆ 64.907109         │                                            
│ 1981-03-01 ┆ 79.058476         │
│ 1981-04-01 ┆ 69.324041         │
│ 1981-05-01 ┆ 88.194466         │
│ …          ┆ …                 │
│ 2024-02-01 ┆ 131.52            │
│ 2024-03-01 ┆ 141.55            │
│ 2024-04-01 ┆ 119.98            │
│ 2024-05-01 ┆ 113.41            │
│ 2024-06-01 ┆ 103.95            │
└────────────┴───────────────────┘ 
3.1.2 :002 > PhillyFrbAsDataframe::PartisanConflict.new.fetch(start: Date.new(2000,01,01), fin: Date.new(2020,12,31))
 => 
shape: (252, 2)                                                               
┌────────────┬───────────────────┐                                            
│ Timestamps ┆ Partisan Conflict │                                            
│ ---        ┆ ---               │                                            
│ date       ┆ f64               │                                            
╞════════════╪═══════════════════╡                                            
│ 2000-01-01 ┆ 77.280948         │                                            
│ 2000-02-01 ┆ 86.638723         │                                            
│ 2000-03-01 ┆ 94.667911         │
│ 2000-04-01 ┆ 80.756581         │
│ 2000-05-01 ┆ 79.505339         │
│ …          ┆ …                 │
│ 2020-08-01 ┆ 98.07             │
│ 2020-09-01 ┆ 116.31            │
│ 2020-10-01 ┆ 137.03            │
│ 2020-11-01 ┆ 156.84            │
│ 2020-12-01 ┆ 117.87            │
└────────────┴───────────────────┘ 
```

and 

```{ruby}
3.1.2 :001 > a = PhillyFrbAsDataframe::SurveyProfForecasters.new
 => #<PhillyFrbAsDataframe::SurveyProfForecasters:0x0000000106e18640> 
3.1.2 :002 > a.fetch
 => 
shape: (223, 308)                    
┌────────────┬────────────┬────────────┬────────────┬───┬──────────────────┬──────────────────┬──────────────────┬──────────────────┐
│ Timestamps ┆ NGDP1      ┆ NGDP2      ┆ NGDP3      ┆ … ┆ RR3_TBILL_CPCE_2 ┆ RR3_TBILL_CPCE_3 ┆ RR3_TBILL_CPCE_4 ┆ RR3_TBILL_CPCE_5 │
│ ---        ┆ ---        ┆ ---        ┆ ---        ┆   ┆ ---              ┆ ---              ┆ ---              ┆ ---              │
│ date       ┆ f64        ┆ f64        ┆ f64        ┆   ┆ f64              ┆ f64              ┆ f64              ┆ f64              │
╞════════════╪════════════╪════════════╪════════════╪═══╪══════════════════╪══════════════════╪══════════════════╪══════════════════╡
│ 1968-10-01 ┆ 870.931    ┆ 884.7816   ┆ 896.5402   ┆ … ┆ null             ┆ null             ┆ null             ┆ null             │
│ 1969-01-01 ┆ 887.8413   ┆ 900.6667   ┆ 912.0476   ┆ … ┆ null             ┆ null             ┆ null             ┆ null             │
│ 1969-04-01 ┆ 903.0169   ┆ 916.8814   ┆ 930.0      ┆ … ┆ null             ┆ null             ┆ null             ┆ null             │
│ 1969-07-01 ┆ 924.9322   ┆ 938.7288   ┆ 950.678    ┆ … ┆ null             ┆ null             ┆ null             ┆ null             │
│ 1969-10-01 ┆ 942.8596   ┆ 954.2632   ┆ 963.7895   ┆ … ┆ null             ┆ null             ┆ null             ┆ null             │
│ …          ┆ …          ┆ …          ┆ …          ┆ … ┆ …                ┆ …                ┆ …                ┆ …                │
│ 2023-04-01 ┆ 26465.8911 ┆ 26717.284  ┆ 26920.0377 ┆ … ┆ 1.4984           ┆ 1.9012           ┆ 2.0303           ┆ 1.9329           │
│ 2023-07-01 ┆ 26834.9959 ┆ 27140.6493 ┆ 27397.6401 ┆ … ┆ 2.3394           ┆ 2.5546           ┆ 2.5933           ┆ 2.4247           │
│ 2023-10-01 ┆ 27623.5055 ┆ 27917.2634 ┆ 28184.9915 ┆ … ┆ 2.7834           ┆ 2.8424           ┆ 2.795            ┆ 2.5619           │
│ 2024-01-01 ┆ 27938.8105 ┆ 28234.0069 ┆ 28497.6187 ┆ … ┆ 3.1199           ┆ 2.983            ┆ 2.692            ┆ 2.4174           │
│ 2024-04-01 ┆ 28284.4998 ┆ 28625.8758 ┆ 28944.1106 ┆ … ┆ 2.5017           ┆ 2.6019           ┆ 2.4432           ┆ 2.1863           │
└────────────┴────────────┴────────────┴────────────┴───┴──────────────────┴──────────────────┴──────────────────┴──────────────────┘ 
3.1.2 :003 > Polars::Config.set_tbl_rows(-1)
 => Polars::Config 
3.1.2 :004 > Polars::Config.set_tbl_cols(-1)
 => Polars::Config 
3.1.2 :005 > a.fetch
 => 
shape: (223, 308)                                           
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│ Tim ┆ NGD ┆ NGD ┆ NGD ┆ NGD ┆ NGD ┆ NGD ┆ NGD ┆ NGD ┆ PGD ┆ PGD ┆ PGD ┆ PGD ┆ PGD ┆ PGD ┆ PGD ┆ PGD ┆ CPR ┆ CPR ┆ CPR ┆ CPR ┆ CPR ┆ CPR ┆ CPR ┆ CPR ┆ UNE ┆ UNE ┆ UNE ┆ UNE ┆ UNE ┆ UNE ┆ UNE ┆ UNE ┆ UNE ┆ UNE ┆ EMP ┆ EMP ┆ EMP ┆ EMP ┆ EMP ┆ EMP ┆ EMP ┆ EMP ┆ IND ┆ IND ┆ IND ┆ IND ┆ IND ┆ IND ┆ IND ┆ IND ┆ HOU ┆ HOU ┆ HOU ┆ HOU ┆ HOU ┆ HOU ┆ HOU ┆ HOU ┆ TBI ┆ TBI ┆ TBI ┆ TBI ┆ TBI ┆ TBI ┆ TBI ┆ TBI ┆ TBI ┆ TBI ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BAA ┆ BAA ┆ BAA ┆ BAA ┆ BAA ┆ BAA ┆ BAA ┆ BAA ┆ TBO ┆ TBO ┆ TBO ┆ TBO ┆ TBO ┆ TBO ┆ TBO ┆ TBO ┆ TBO ┆ TBO ┆ RGD ┆ RGD ┆ RGD ┆ RGD ┆ RGD ┆ RGD ┆ RGD ┆ RGD ┆ RGD ┆ RGD ┆ RCO ┆ RCO ┆ RCO ┆ RCO ┆ RCO ┆ RCO ┆ RCO ┆ RCO ┆ RNR ┆ RNR ┆ RNR ┆ RNR ┆ RNR ┆ RNR ┆ RNR ┆ RNR ┆ RRE ┆ RRE ┆ RRE ┆ RRE ┆ RRE ┆ RRE ┆ RRE ┆ RRE ┆ RFE ┆ RFE ┆ RFE ┆ RFE ┆ RFE ┆ RFE ┆ RFE ┆ RFE ┆ RSL ┆ RSL ┆ RSL ┆ RSL ┆ RSL ┆ RSL ┆ RSL ┆ RSL ┆ RCB ┆ RCB ┆ RCB ┆ RCB ┆ RCB ┆ RCB ┆ RCB ┆ RCB ┆ REX ┆ REX ┆ REX ┆ REX ┆ REX ┆ REX ┆ REX ┆ REX ┆ CPI ┆ PCE ┆ CPI ┆ PCE ┆ RGD ┆ PRO ┆ STO ┆ BON ┆ BIL ┆ CPI ┆ CPI ┆ CPI ┆ CPI ┆ CPI ┆ CPI ┆ CPI ┆ CPI ┆ CPI ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ PCE ┆ PCE ┆ PCE ┆ PCE ┆ PCE ┆ PCE ┆ PCE ┆ PCE ┆ PCE ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ COR ┆ UBA ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ SPR ┆ cpi ┆ pce ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR3 ┆ RR3 ┆ RR3 ┆ RR3 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR3 ┆ RR3 ┆ RR3 ┆ RR3 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR3 ┆ RR3 ┆ RR3 ┆ RR3 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR3 ┆ RR3 ┆ RR3 ┆ RR3 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR1 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR2 ┆ RR3 ┆ RR3 ┆ RR3 ┆ RR3 │
│ est ┆ P1  ┆ P2  ┆ P3  ┆ P4  ┆ P5  ┆ P6  ┆ PA  ┆ PB  ┆ P1  ┆ P2  ┆ P3  ┆ P4  ┆ P5  ┆ P6  ┆ PA  ┆ PB  ┆ OF1 ┆ OF2 ┆ OF3 ┆ OF4 ┆ OF5 ┆ OF6 ┆ OFA ┆ OFB ┆ MP1 ┆ MP2 ┆ MP3 ┆ MP4 ┆ MP5 ┆ MP6 ┆ MPA ┆ MPB ┆ MPC ┆ MPD ┆ 1   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 6   ┆ A   ┆ B   ┆ PRO ┆ PRO ┆ PRO ┆ PRO ┆ PRO ┆ PRO ┆ PRO ┆ PRO ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ LL1 ┆ LL2 ┆ LL3 ┆ LL4 ┆ LL5 ┆ LL6 ┆ LLA ┆ LLB ┆ LLC ┆ LLD ┆ D1  ┆ D2  ┆ D3  ┆ D4  ┆ D5  ┆ D6  ┆ DA  ┆ DB  ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ ND1 ┆ ND2 ┆ ND3 ┆ ND4 ┆ ND5 ┆ ND6 ┆ NDA ┆ NDB ┆ NDC ┆ NDD ┆ P1  ┆ P2  ┆ P3  ┆ P4  ┆ P5  ┆ P6  ┆ PA  ┆ PB  ┆ PC  ┆ PD  ┆ NSU ┆ NSU ┆ NSU ┆ NSU ┆ NSU ┆ NSU ┆ NSU ┆ NSU ┆ ESI ┆ ESI ┆ ESI ┆ ESI ┆ ESI ┆ ESI ┆ ESI ┆ ESI ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ SIN ┆ DGO ┆ DGO ┆ DGO ┆ DGO ┆ DGO ┆ DGO ┆ DGO ┆ DGO ┆ GOV ┆ GOV ┆ GOV ┆ GOV ┆ GOV ┆ GOV ┆ GOV ┆ GOV ┆ I1  ┆ I2  ┆ I3  ┆ I4  ┆ I5  ┆ I6  ┆ IA  ┆ IB  ┆ POR ┆ POR ┆ POR ┆ POR ┆ POR ┆ POR ┆ POR ┆ POR ┆ 5YR ┆ 5YR ┆ 10  ┆ 10  ┆ P10 ┆ D10 ┆ CK1 ┆ D10 ┆ L10 ┆ 1   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 6   ┆ A   ┆ B   ┆ C   ┆ ECP ┆ ECP ┆ ECP ┆ ECP ┆ ECP ┆ ECP ┆ ECP ┆ ECP ┆ ECP ┆ 1   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 6   ┆ A   ┆ B   ┆ C   ┆ EPC ┆ EPC ┆ EPC ┆ EPC ┆ EPC ┆ EPC ┆ EPC ┆ EPC ┆ EPC ┆ R   ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _BA ┆ _AA ┆ _AA ┆ _AA ┆ _AA ┆ _AA ┆ _AA ┆ _AA ┆ _AA ┆ f5  ┆ f5  ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB ┆ _TB │
│ amp ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ D1  ┆ D2  ┆ D3  ┆ D4  ┆ D5  ┆ D6  ┆ DA  ┆ DB  ┆ G1  ┆ G2  ┆ G3  ┆ G4  ┆ G5  ┆ G6  ┆ GA  ┆ GB  ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ D1  ┆ D2  ┆ D3  ┆ D4  ┆ D5  ┆ D6  ┆ DA  ┆ DB  ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ M1  ┆ M2  ┆ M3  ┆ M4  ┆ M5  ┆ M6  ┆ MA  ┆ MB  ┆ N1  ┆ N2  ┆ N3  ┆ N4  ┆ N5  ┆ N6  ┆ NA  ┆ NB  ┆ V1  ┆ V2  ┆ V3  ┆ V4  ┆ V5  ┆ V6  ┆ VA  ┆ VB  ┆ V1  ┆ V2  ┆ V3  ┆ V4  ┆ V5  ┆ V6  ┆ VA  ┆ VB  ┆ 1   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 6   ┆ A   ┆ B   ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ T1  ┆ T2  ┆ T3  ┆ T4  ┆ T5  ┆ T6  ┆ TA  ┆ TB  ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ 0   ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ I1  ┆ I2  ┆ I3  ┆ I4  ┆ I5  ┆ I6  ┆ IA  ┆ IB  ┆ IC  ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ E1  ┆ E2  ┆ E3  ┆ E4  ┆ E5  ┆ E6  ┆ EA  ┆ EB  ┆ EC  ┆ --- ┆ ond ┆ ond ┆ ond ┆ ond ┆ ond ┆ ond ┆ ond ┆ ond ┆ ond ┆ ond ┆ A_A ┆ A_A ┆ A_A ┆ A_A ┆ A_A ┆ A_A ┆ A_A ┆ A_A ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ A_T ┆ --- ┆ --- ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL ┆ ILL │
│ s   ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ nul ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ f64 ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ _Tb ┆ AA1 ┆ AA2 ┆ AA3 ┆ AA4 ┆ AA5 ┆ AA6 ┆ AAA ┆ AAB ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ BON ┆ f64 ┆ f64 ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _PG ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _CC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _PC ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP ┆ _CP │
│ --- ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ l   ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ nul ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆ ill ┆ ill ┆ ill ┆ ill ┆ ill ┆ ill ┆ ill ┆ ill ┆ ill ┆ ill ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ D1  ┆ D2  ┆ D3  ┆ D4  ┆ D5  ┆ D6  ┆ DA  ┆ DB  ┆ D1  ┆ D2  ┆ D3  ┆ D4  ┆ D5  ┆ D6  ┆ DA  ┆ DB  ┆     ┆     ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ DP_ ┆ I_2 ┆ I_3 ┆ I_4 ┆ I_5 ┆ I_6 ┆ I_2 ┆ I_3 ┆ I_4 ┆ I_5 ┆ I_2 ┆ I_3 ┆ I_4 ┆ I_5 ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ PI_ ┆ E_2 ┆ E_3 ┆ E_4 ┆ E_5 ┆ E_6 ┆ E_2 ┆ E_3 ┆ E_4 ┆ E_5 ┆ E_2 ┆ E_3 ┆ E_4 ┆ E_5 ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ ┆ CE_ │
│ dat ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ l   ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ 1   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 6   ┆ A   ┆ B   ┆ C   ┆ D   ┆ nul ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆     ┆     ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 6   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 6   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 6   ┆ 2   ┆ 3   ┆ 4   ┆ 5   ┆ 2   ┆ 3   ┆ 4   ┆ 5   │
│ e   ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ l   ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ nul ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ nul ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆     ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- ┆ --- │
│     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ l   ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ l   ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆     ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 ┆ f64 │
╞═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╪═════╡
│ 196 ┆ 870 ┆ 884 ┆ 896 ┆ 908 ┆ 923 ┆ 939 ┆ nul ┆ nul ┆ 122 ┆ 123 ┆ 124 ┆ 125 ┆ 126 ┆ 126 ┆ nul ┆ nul ┆ 51. ┆ 51. ┆ 50. ┆ 51. ┆ 51. ┆ 52. ┆ nul ┆ nul ┆ 3.5 ┆ 3.6 ┆ 3.8 ┆ 4.0 ┆ 3.9 ┆ 3.9 ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ 164 ┆ 165 ┆ 166 ┆ 166 ┆ 168 ┆ 170 ┆ nul ┆ nul ┆ 1.5 ┆ 1.5 ┆ 1.5 ┆ 1.5 ┆ 1.6 ┆ 1.6 ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ 713 ┆ 717 ┆ 721 ┆ 726 ┆ 733 ┆ 740 ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul ┆ nul │
│ 8-1 ┆ .93 ┆ .78 ┆ .54 ┆ .77 ┆ .77 ┆ .79 ┆ l   ┆ l   ┆ .0  ┆ .32 ┆ .28 ┆ .16 ┆ .01 ┆ .86 ┆ l   ┆ l   ┆ 023 ┆ 255 ┆ 914 ┆ 059 ┆ 988 ┆ 938 ┆ l   ┆ l   ┆ 974 ┆ 218 ┆ 359 ┆ 231 ┆ 91  ┆ 397 ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ .80 ┆ .67 ┆ .02 ┆ .56 ┆ .25 ┆ .07 ┆ l   ┆ l   ┆ 194 ┆ 298 ┆ 442 ┆ 843 ┆ 407 ┆ 819 ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ .87 ┆ .48 ┆ .38 ┆ .14 ┆ .16 ┆ .82 ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   ┆ l   │

(...snip...)

3.1.2 :006 > b = a.fetch
 => 
shape: (223, 308)        
...                      
3.1.2 :007 > b.columns
 => 
["Timestamps",                                 
 "NGDP1",                                      
 "NGDP2",                                      
 "NGDP3",                                      
 "NGDP4",                                      
 "NGDP5",                                      
 "NGDP6",                                      
 "NGDPA",                                      
 "NGDPB",                                      
 "PGDP1",                                      
 "PGDP2",                                      
 "PGDP3",                                      
 "PGDP4",                                      
 "PGDP5",                                      
 "PGDP6",
 "PGDPA",
 "PGDPB",

 (...snip...)

 "RR3_TBILL_CPCE_2",
 "RR3_TBILL_CPCE_3",
 "RR3_TBILL_CPCE_4",
 "RR3_TBILL_CPCE_5"] 
3.1.2 :008 >  b['Timestamps']
 => 
shape: (223,)             
Series: 'Timestamps' [date]
[                         
    1968-10-01        
    1969-01-01        
    1969-04-01
    1969-07-01
    1969-10-01
    1970-01-01
    1970-04-01
    1970-07-01
    1970-10-01

 (...snip...)

    2023-07-01
    2023-10-01
    2024-01-01
    2024-04-01
] 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/philly_frb_as_dataframe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/philly_frb_as_dataframe/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PhillyFrbAsDataframe project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/philly_frb_as_dataframe/blob/main/CODE_OF_CONDUCT.md).

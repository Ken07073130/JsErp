--2015/05/20
--1.补投单修改适应WEB版
drop table js_btdH
select * into js_btdH from dbo.js_btpsdH;
EXEC sp_rename 'js_btdH.[RQ]', 'JBRQ', 'COLUMN';
EXEC sp_rename 'js_btdH.[DH]', 'BH', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZZLPSJG]', 'ZJLZLPSJG', 'COLUMN';
EXEC sp_rename 'js_btdH.[SWPSJG]', 'SWJLPSJG', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZLHQRQ]', 'ZLHQSJ', 'COLUMN';
EXEC sp_rename 'js_btdH.[GCHQRQ]', 'GCHQSJ', 'COLUMN';
EXEC sp_rename 'js_btdH.[GYLHQRQ]', 'GYLHQSJ', 'COLUMN';
EXEC sp_rename 'js_btdH.[SWHQR]', 'SWJLHQR', 'COLUMN';
EXEC sp_rename 'js_btdH.[SWHQSJ]', 'SWJLHQSJ', 'COLUMN';
EXEC sp_rename 'js_btdH.[SBHQRQ]', 'SBHQSJ', 'COLUMN';
EXEC sp_rename 'js_btdH.[SWBTHQZT]', 'PMCHQZT', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZLBHQZT]', 'ZLHQZT', 'COLUMN';
EXEC sp_rename 'js_btdH.[GCBHQZT]', 'GCHQZT', 'COLUMN';
EXEC sp_rename 'js_btdH.[SSBHQZT]', 'SBHQZT', 'COLUMN';
EXEC sp_rename 'js_btdH.[SWBHQZT]', 'SWJLHQZT', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZLBBZ]', 'ZLBZ', 'COLUMN';
EXEC sp_rename 'js_btdH.[SWPSBZ]', 'SWJLBZ', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZZPSBZ]', 'ZJLZLBZ', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZZHQZT]', 'ZJLZLHQZT', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZZHQSJ]', 'ZJLZLHQSJ', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZZHQRQ]', 'ZZHQSJ', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZZBHQZT]', 'ZZHQZT', 'COLUMN';
EXEC sp_rename 'js_btdH.[ZZGHR]', 'ZJLZLHQR', 'COLUMN';


alter table js_btdH alter column ZZBZ varchar(1000);
alter table js_btdH alter column ZLBZ varchar(1000);
alter table js_btdH alter column SBBZ varchar(1000);
alter table js_btdH alter column SCZJBZ varchar(1000);
alter table js_btdH alter column GYLBZ varchar(1000);
alter table js_btdH alter column SWJLBZ varchar(1000);
alter table js_btdH alter column ZGBZ varchar(1000);
alter table js_btdH alter column ZJLZLBZ varchar(1000);
alter table dbo.js_btdH alter column PACKYJBT int;

alter table js_btdH drop column JSHQR;
alter table js_btdH drop column JSHQSJ;
alter table js_btdH drop column JSBHQZT;
alter table js_btdH drop column JSBZ;

alter table js_btdH add GGSXH varchar(30);
alter table js_btdH add NBBZXH varchar(30);
alter table js_btdH add NBPACKXH varchar(30);
alter table js_btdH add PMCBZ varchar(300);
alter table js_btdH add GCBZ varchar(300);
alter table js_btdH add RL varchar(30);


insert into dbo.js_controlEnable
        ( djmc, lx, mc,  zd )
select '生产补投单','TEXTBOX','tbBh','BH' union all 
select '生产补投单','TEXTBOX','tbTc','TC' union all 
select '生产补投单','TEXTBOX','tbJbrq','JBRQ' union all 
select '生产补投单','TEXTBOX','tbKhdm','KHDM' union all 
select '生产补投单','TEXTBOX','tbDdh','DDH' union all 
select '生产补投单','TEXTBOX','tbQhsl','QHSL' union all 
select '生产补投单','TEXTBOX','tbDdzsl','DDZSL' union all 
select '生产补投单','TEXTBOX','tbPsdzl','PSDZL' union all 
select '生产补投单','TEXTBOX','tbPsjq','PSJQ' union all 
select '生产补投单','TEXTBOX','tbJqyc','JQYC' union all 
select '生产补投单','TEXTBOX','tbRl','RL' union all 
select '生产补投单','TEXTBOX','tbGgsxh','GGSXH' union all 
select '生产补投单','TEXTBOX','tbNbdxxh','NBDXXH' union all 
select '生产补投单','TEXTBOX','tbNbbzxh','NBBZXH' union all 
select '生产补投单','TEXTBOX','tbNbpackxh','NBPACKXH' union all 
select '生产补投单','TEXTBOX','tbDxyjbt','DXYJBT' union all 
select '生产补投单','TEXTBOX','tbZjyjbt','ZJYJBT' union all 
select '生产补投单','TEXTBOX','tbFjyjbt','FJYJBT' union all 
select '生产补投单','TEXTBOX','tbPackyjbt','PACKYJBT' union all 
select '生产补投单','TEXTBOX','tbScph','SCPH' union all 
select '生产补投单','TEXTBOX','tbQkms','QKMS' union all 
select '生产补投单','DROPDOWNLIST','ddlPMCpsjg','PMCPSJG' union all 
select '生产补投单','TEXTBOX','tbPMChqr','PMCHQR' union all 
select '生产补投单','TEXTBOX','tbPMChqsj','PMCHQSJ' union all 
select '生产补投单','TEXTBOX','tbPMCbz','PMCBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlZlpsjg','ZLPSJG' union all 
select '生产补投单','TEXTBOX','tbZlhqr','ZLHQR' union all 
select '生产补投单','TEXTBOX','tbZlhqsj','ZLHQSJ' union all 
select '生产补投单','TEXTBOX','tbZlbz','ZLBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlGcpsjg','GCPSJG' union all 
select '生产补投单','TEXTBOX','tbGchqr','GCHQR' union all 
select '生产补投单','TEXTBOX','tbGchqsj','GCHQSJ' union all 
select '生产补投单','TEXTBOX','tbGcbz','GCBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlZzpsjg','ZZPSJG' union all 
select '生产补投单','TEXTBOX','tbZzhqr','ZZHQR' union all 
select '生产补投单','TEXTBOX','tbZzhqsj','ZZHQSJ' union all 
select '生产补投单','TEXTBOX','tbZzbz','ZZBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlSbpsjg','SBPSJG' union all 
select '生产补投单','TEXTBOX','tbSbhqr','SBHQR' union all 
select '生产补投单','TEXTBOX','tbSbhqsj','SBHQSJ' union all 
select '生产补投单','TEXTBOX','tbSbbz','SBBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlSczjpsjg','SCZJPSJG' union all 
select '生产补投单','TEXTBOX','tbSczjhqr','SCZJHQR' union all 
select '生产补投单','TEXTBOX','tbSczjhqsj','SCZJHQSJ' union all 
select '生产补投单','TEXTBOX','tbSczjbz','SCZJBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlZgpsjg','ZGPSJG' union all 
select '生产补投单','TEXTBOX','tbZghqr','ZGHQR' union all 
select '生产补投单','TEXTBOX','tbZghqsj','ZGHQSJ' union all 
select '生产补投单','TEXTBOX','tbZgbz','ZGBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlGylpsjg','GYLPSJG' union all 
select '生产补投单','TEXTBOX','tbGylhqr','GYLHQR' union all 
select '生产补投单','TEXTBOX','tbGylhqsj','GYLHQSJ' union all 
select '生产补投单','TEXTBOX','tbGylbz','GYLBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlSwjlpsjg','SWJLPSJG' union all 
select '生产补投单','TEXTBOX','tbSwjlhqr','SWJLHQR' union all 
select '生产补投单','TEXTBOX','tbSwjlhqsj','SWJLHQSJ' union all 
select '生产补投单','TEXTBOX','tbSwjlbz','SWJLBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlZjlzlpsjg','ZJLZLPSJG' union all 
select '生产补投单','TEXTBOX','tbZjlzlhqr','ZJLZLHQR' union all 
select '生产补投单','TEXTBOX','tbZjlzlhqsj','ZJLZLHQSJ' union all 
select '生产补投单','TEXTBOX','tbZjlzlbz','ZJLZLBZ' union all 
select '生产补投单','DROPDOWNLIST','ddlPMChqzt','PMCHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlZlhqzt','ZLHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlGchqzt','GCHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlZzhqzt','ZZHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlSbhqzt','SBHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlSczjhqzt','SCZJHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlZghqzt','ZGHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlGylhqzt','GYLHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlSwjlhqzt','SWJLHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlZjlzlhqzt','ZJLZLHQZT' union all 
select '生产补投单','DROPDOWNLIST','ddlDw1','DW1' union all 
select '生产补投单','DROPDOWNLIST','ddlDw2','DW2' union all 
select '生产补投单','DROPDOWNLIST','ddlDw3','DW3' union all 
select '生产补投单','DROPDOWNLIST','ddlDw4','DW4' union all 
select '生产补投单','DROPDOWNLIST','ddlDw5','DW5' union all 
select '生产补投单','DROPDOWNLIST','ddlDw6','DW6' union all 
select '生产补投单','DROPDOWNLIST','ddlDw7','DW7' union all 
select '生产补投单','DROPDOWNLIST','ddlDw8','DW8' 


create table js_btd_list
(
  djlsh int identity(1,1),
  btdbh varchar(30),
  blxm  varchar(50),
  sl    int,
  wtms  varchar(300),
  fsyy  varchar(500),
  dc    varchar(500)
)


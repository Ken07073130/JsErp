--���ò�ѯ
select * from dbo.STUsers where UserName  like '%��%';
select * from dbo.js_shortMessage;
select * from dbo.js_shortMessage_history order by sendTime desc;


--2015/05/20
--1.��Ͷ���޸���ӦWEB��
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
select '������Ͷ��','TEXTBOX','tbBh','BH' union all 
select '������Ͷ��','TEXTBOX','tbTc','TC' union all 
select '������Ͷ��','TEXTBOX','tbJbrq','JBRQ' union all 
select '������Ͷ��','TEXTBOX','tbKhdm','KHDM' union all 
select '������Ͷ��','TEXTBOX','tbDdh','DDH' union all 
select '������Ͷ��','TEXTBOX','tbQhsl','QHSL' union all 
select '������Ͷ��','TEXTBOX','tbDdzsl','DDZSL' union all 
select '������Ͷ��','TEXTBOX','tbPsdzl','PSDZL' union all 
select '������Ͷ��','TEXTBOX','tbPsjq','PSJQ' union all 
select '������Ͷ��','TEXTBOX','tbJqyc','JQYC' union all 
select '������Ͷ��','TEXTBOX','tbRl','RL' union all 
select '������Ͷ��','TEXTBOX','tbGgsxh','GGSXH' union all 
select '������Ͷ��','TEXTBOX','tbNbdxxh','NBDXXH' union all 
select '������Ͷ��','TEXTBOX','tbNbbzxh','NBBZXH' union all 
select '������Ͷ��','TEXTBOX','tbNbpackxh','NBPACKXH' union all 
select '������Ͷ��','TEXTBOX','tbDxyjbt','DXYJBT' union all 
select '������Ͷ��','TEXTBOX','tbZjyjbt','ZJYJBT' union all 
select '������Ͷ��','TEXTBOX','tbFjyjbt','FJYJBT' union all 
select '������Ͷ��','TEXTBOX','tbPackyjbt','PACKYJBT' union all 
select '������Ͷ��','TEXTBOX','tbScph','SCPH' union all 
select '������Ͷ��','TEXTBOX','tbQkms','QKMS' union all 
select '������Ͷ��','DROPDOWNLIST','ddlPMCpsjg','PMCPSJG' union all 
select '������Ͷ��','TEXTBOX','tbPMChqr','PMCHQR' union all 
select '������Ͷ��','TEXTBOX','tbPMChqsj','PMCHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbPMCbz','PMCBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlZlpsjg','ZLPSJG' union all 
select '������Ͷ��','TEXTBOX','tbZlhqr','ZLHQR' union all 
select '������Ͷ��','TEXTBOX','tbZlhqsj','ZLHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbZlbz','ZLBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlGcpsjg','GCPSJG' union all 
select '������Ͷ��','TEXTBOX','tbGchqr','GCHQR' union all 
select '������Ͷ��','TEXTBOX','tbGchqsj','GCHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbGcbz','GCBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlZzpsjg','ZZPSJG' union all 
select '������Ͷ��','TEXTBOX','tbZzhqr','ZZHQR' union all 
select '������Ͷ��','TEXTBOX','tbZzhqsj','ZZHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbZzbz','ZZBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlSbpsjg','SBPSJG' union all 
select '������Ͷ��','TEXTBOX','tbSbhqr','SBHQR' union all 
select '������Ͷ��','TEXTBOX','tbSbhqsj','SBHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbSbbz','SBBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlSczjpsjg','SCZJPSJG' union all 
select '������Ͷ��','TEXTBOX','tbSczjhqr','SCZJHQR' union all 
select '������Ͷ��','TEXTBOX','tbSczjhqsj','SCZJHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbSczjbz','SCZJBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlZgpsjg','ZGPSJG' union all 
select '������Ͷ��','TEXTBOX','tbZghqr','ZGHQR' union all 
select '������Ͷ��','TEXTBOX','tbZghqsj','ZGHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbZgbz','ZGBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlGylpsjg','GYLPSJG' union all 
select '������Ͷ��','TEXTBOX','tbGylhqr','GYLHQR' union all 
select '������Ͷ��','TEXTBOX','tbGylhqsj','GYLHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbGylbz','GYLBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlSwjlpsjg','SWJLPSJG' union all 
select '������Ͷ��','TEXTBOX','tbSwjlhqr','SWJLHQR' union all 
select '������Ͷ��','TEXTBOX','tbSwjlhqsj','SWJLHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbSwjlbz','SWJLBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlZjlzlpsjg','ZJLZLPSJG' union all 
select '������Ͷ��','TEXTBOX','tbZjlzlhqr','ZJLZLHQR' union all 
select '������Ͷ��','TEXTBOX','tbZjlzlhqsj','ZJLZLHQSJ' union all 
select '������Ͷ��','TEXTBOX','tbZjlzlbz','ZJLZLBZ' union all 
select '������Ͷ��','DROPDOWNLIST','ddlPMChqzt','PMCHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlZlhqzt','ZLHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlGchqzt','GCHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlZzhqzt','ZZHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlSbhqzt','SBHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlSczjhqzt','SCZJHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlZghqzt','ZGHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlGylhqzt','GYLHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlSwjlhqzt','SWJLHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlZjlzlhqzt','ZJLZLHQZT' union all 
select '������Ͷ��','DROPDOWNLIST','ddlDw1','DW1' union all 
select '������Ͷ��','DROPDOWNLIST','ddlDw2','DW2' union all 
select '������Ͷ��','DROPDOWNLIST','ddlDw3','DW3' union all 
select '������Ͷ��','DROPDOWNLIST','ddlDw4','DW4' union all 
select '������Ͷ��','DROPDOWNLIST','ddlDw5','DW5' union all 
select '������Ͷ��','DROPDOWNLIST','ddlDw6','DW6' union all 
select '������Ͷ��','DROPDOWNLIST','ddlDw7','DW7' union all 
select '������Ͷ��','DROPDOWNLIST','ddlDw8','DW8' 


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


--2014/05/22 �������URL
update Erp_js_Sys.dbo.Tree set URL='swxt/btdList.aspx' where NodeCaption='������Ͷ����'
update Erp_js_Sys.dbo.Tree set URL='swxt/htpsbList.aspx' where NodeCaption='��ͬ�����'
create view view_htpsbOnBtd as
    select bh,nbdxxh ,nbPACKXH,KHXH ,khdm ,
	  convert(varchar(10), tcsl) + '(' + dw2 + ')' ddsl ,
      convert(varchar(10), jbrq, 120) jbrq , khddh  from  dbo.js_htpsbH
    union all
    select bh,nbdxxh ,nbPACKXH,'' ,khdm ,
      convert(varchar(10), isnull(ZJYJBT,0)+isnull(FJYJBT,0)+isnull(DXYJBT,0)+isnull(PACKYJBT,0)) + '(' + DW1 + ')' ddsl ,
      convert(varchar(10), jbrq, 120) jbrq , DDH  from  dbo.js_btdH

--2015/05/23 �������ϵ�������״̬�ֶ�
alter table dbo.js_tldH add sczt varchar(30)

--2015/5/25  ͬ����ͬ����
insert into dbo.js_htpsbH (DjLsh,lchqzt,bh,jbrq,bb,khdm,ddsl,dxsl,KHXH,khyqjq,khddh,bbsl,nbdxxh,
wspsjq,ggsbh,ggsbb,nbPACKXH,HSFyq,QT,sykxx,ggssfqh,tlsj,PACKsj,lhsj,gyxfsj,motzxfsj,gzfzxfsj,
cldexfsj,cltx,PACKgydecfsj,PACKmzyq,gmdwsj,bhbdwsj,wfmzjq,sbnfmz,ywpzyc,cnwt,PACKbz,gcbz,gylbz,zlbz,zzbz,
PSJL,DDLX,sctl,bhdh,bhsl,ZGBZ,swjlbz,sczjbz,zbr,dw,RoHS,REACH,wlyq,CHBZDM,PMYQ,DXBL,PACKBL,
TCSL,KCSL,KCCH,dw1,dw2,dw3,dw4,scsc,lckxx,gylxkxx,sfywjawt,gylx,fqrhqzt,pmchqzt,jsbhqzt,packhqzt,
gylhqzt,zghqzt,sczjhqzt,swjlhqzt,gchqzt,sbhqzt,zlhqzt,zzhqzt,LSLS,NBBZXH,CPLX,GGSXH,PMCPSJG,PMCHQR,
PMCHQSJ,gcpsjg,gchqr,gchqsj,sbpsjg,sbhqr,sbhqsj,zlpsjg,zlhqr,zlhqsj,gylpsjg,gylhqr,gylhqsj,PACKpsjg,
PACKhqr,Packhqsj,zzpsjg,zzhqr,zzhqsj,sczjpsjg,sczjhqr,sczjhqsj,zgpsjg,zghqr,zghqsj,swjlpsjg,swjlhqr,
swjlhqsj,PMCbz,sbbz,ddcf,bgly,dyzt,tlzt,tczt,changeControl)
select DjLsh,lchqzt,psdbh,jbrq,bb,khdm,ddsl,dxsl,KHXH,khyqjq,khddh,bbsl,nbdxxh,
wspsjq,ggsbh,ggsbb,nbPACKXH,HSPyq,QT,sykxx,ggssfqh,tlsj,PACKsj,lhsj,gyxfsj,motzxfsj,gzfzxfsj,
cldexfsj,cltx,PACKgydecfsj,PACKmzyq,gmdwsj,bhbdwsj,wfmzjq,sbnfmz,ywpzyc,cnwt,jsPACKbz,gcbz,gylbz,zlbz,zzbz,
'',DDLX,sctl,bhdh,bhsl,ZGBZ,swjlbz,sczjbz,zbr,dw,RoHS,REACH,wlyq,CHBZDM,PMYQ,DXBL,PACKBL,
TCSL,KCSL,KCCH,dw1,dw2,dw3,dw4,scsc,lckxx,gylxkxx,sfywjawt,'',fqrhqzt,swbhqzt,jsbhqzt,jspackhqzt,
gylhqzt,zghqzt,sczjhqzt,swjlhqzt,gcbhqzt,sbbhqzt,zlbhqzt,zzbhqzt,LSLS,NBBZXH,CPLX,GGSXH,SWPSJG,swjlqz,
swqzsj,gcpsjg,gcjlqm,gchqsj,sbpsjg,sbjlqm,sbhqsj,zlpsjg,zljl,zlqzsj,gylpsjg,gyljlqm,gylqmsj,PACKpsjg,
PACKhqsj,jsPackhqsj,zzpsjg,zzjlqm,zzhqsj,sczjps,sczjqz,sczjshsj,psjg,zgqz,zgshrq,swjlpsjg,swjlqz,
swjlshsj,swbz,sbbbz,'��','','','','','' from dbo.js_htpsb_newH
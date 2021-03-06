create cached table T_ALBUM ( ALB_ID_C varchar(36) not null, ALB_IDDIRECTORY_C varchar(36) not null, ALB_IDARTIST_C varchar(36) not null, ALB_NAME_C varchar(1000) not null, ALB_ALBUMART_C varchar(36), ALB_LOCATION_C varchar(2000) not null, ALB_UPDATEDATE_D datetime not null,  ALB_CREATEDATE_D datetime not null, ALB_DELETEDATE_D datetime, primary key (ALB_ID_C) );
create cached table T_ARTIST ( ART_ID_C varchar(36) not null, ART_NAME_C varchar(1000) not null, ART_NAMECORRECTED_C varchar(1000), ART_CREATEDATE_D datetime not null, ART_DELETEDATE_D datetime, primary key (ART_ID_C) );
create memory table T_AUTHENTICATION_TOKEN ( AUT_ID_C varchar(36) not null, AUT_IDUSER_C varchar(36) not null, AUT_LONGLASTED_B bit not null, AUT_CREATEDATE_D datetime not null, AUT_LASTCONNECTIONDATE_D datetime, primary key (AUT_ID_C) );
create memory table T_BASE_FUNCTION ( BAF_ID_C varchar(20) not null, primary key (BAF_ID_C) );
create memory table T_CONFIG ( CFG_ID_C varchar(50) not null, CFG_VALUE_C varchar(250) not null, primary key (CFG_ID_C) );
create memory table T_DIRECTORY ( DIR_ID_C varchar(36) not null, DIR_LOCATION_C varchar(1000), DIR_CREATEDATE_D datetime not null, DIR_DISABLEDATE_D datetime, DIR_DELETEDATE_D datetime, primary key (DIR_ID_C) );
create memory table T_LOCALE ( LOC_ID_C varchar(10) not null, primary key (LOC_ID_C) );
create cached table T_PLAYLIST ( PLL_ID_C varchar(36) not null, PLL_IDUSER_C varchar(36) not null, primary key (PLL_ID_C) );
create cached table T_PLAYLIST_TRACK ( PLT_ID_C varchar(36) not null, PLT_IDPLAYLIST_C varchar(36) not null, PLT_IDTRACK_C varchar(36) not null, PLT_ORDER_N int not null, primary key (PLT_ID_C) );
create memory table T_ROLE ( ROL_ID_C varchar(36) not null, ROL_NAME_C varchar(50) not null, ROL_CREATEDATE_D datetime not null, ROL_DELETEDATE_D datetime, primary key (ROL_ID_C) );
create memory table T_ROLE_BASE_FUNCTION ( RBF_ID_C varchar(36) not null, RBF_IDROLE_C varchar(36), RBF_IDBASEFUNCTION_C varchar(20) not null, RBF_CREATEDATE_D datetime not null, RBF_DELETEDATE_D datetime, primary key (RBF_ID_C) );
create cached table T_TRACK ( TRK_ID_C varchar(36) not null, TRK_IDALBUM_C varchar(36) not null, TRK_IDARTIST_C varchar(36) not null, TRK_FILENAME_C varchar(2000) not null, TRK_TITLE_C varchar(2000) not null, TRK_TITLECORRECTED_C varchar(2000), TRK_YEAR_N integer, TRK_GENRE_C varchar(100), TRK_LENGTH_N integer not null, TRK_BITRATE_N integer not null, TRK_ORDER_N integer, TRK_VBR_B bit not null, TRK_FORMAT_C varchar(50) not null, TRK_CREATEDATE_D datetime not null, TRK_DELETEDATE_D datetime, primary key (TRK_ID_C) );
create memory table T_TRANSCODER ( TRN_ID_C varchar(36) not null, TRN_NAME_C varchar(100) not null, TRN_SOURCE_C varchar(1000) not null, TRN_DESTINATION_C varchar(100) not null, TRN_STEP1_C varchar(1000) not null, TRN_STEP2_C varchar(1000), TRN_CREATEDATE_D datetime not null, TRN_DELETEDATE_D datetime, primary key (TRN_ID_C) );
create memory table T_USER ( USE_ID_C varchar(36) not null, USE_IDLOCALE_C varchar(10) not null, USE_IDROLE_C varchar(36) not null, USE_USERNAME_C varchar(50) not null, USE_PASSWORD_C varchar(60) not null, USE_EMAIL_C varchar(100) not null, USE_MAXBITRATE_N integer, USE_LASTFMSESSIONTOKEN_C varchar(100), USE_LASTFMACTIVE_B bit default 0 not null, USE_FIRSTCONNECTION_B bit default 0 not null, USE_CREATEDATE_D datetime not null, USE_DELETEDATE_D datetime, primary key (USE_ID_C) );
create cached table T_USER_ALBUM ( USA_ID_C varchar(36) not null, USA_IDUSER_C varchar(36) not null, USA_IDALBUM_C varchar(36) not null, USA_SCORE_N integer not null default 0, USA_CREATEDATE_D datetime not null, USA_DELETEDATE_D datetime, primary key (USA_ID_C) );
create cached table T_USER_TRACK ( UST_ID_C varchar(36) not null, UST_IDUSER_C varchar(36) not null, UST_IDTRACK_C varchar(36) not null, UST_PLAYCOUNT_N integer default 0 not null, UST_LIKE_B bit default 0 not null, UST_CREATEDATE_D datetime not null, UST_DELETEDATE_D datetime, primary key (UST_ID_C) );
create cached table T_PLAYER ( PLR_ID_C varchar(36) not null, primary key (PLR_ID_C) );
alter table T_ALBUM add constraint FK_ALB_IDARTIST_C foreign key (ALB_IDARTIST_C) references T_ARTIST (ART_ID_C) on delete restrict on update restrict;
alter table T_ALBUM add constraint FK_ALB_IDDIRECTORY_C foreign key (ALB_IDDIRECTORY_C) references T_DIRECTORY (DIR_ID_C) on delete restrict on update restrict;
alter table T_AUTHENTICATION_TOKEN add constraint FK_AUT_IDUSER_C foreign key (AUT_IDUSER_C) references T_USER (USE_ID_C) on delete restrict on update restrict;
alter table T_PLAYLIST add constraint FK_PLL_IDUSER_C foreign key (PLL_IDUSER_C) references T_USER (USE_ID_C) on delete restrict on update restrict;
alter table T_PLAYLIST_TRACK add constraint FK_PLT_IDTRACK_C foreign key (PLT_IDTRACK_C) references T_TRACK (TRK_ID_C) on delete restrict on update restrict;
alter table T_PLAYLIST_TRACK add constraint FK_PLT_IDPLAYLIST_C foreign key (PLT_IDPLAYLIST_C) references T_PLAYLIST (PLL_ID_C) on delete restrict on update restrict;
alter table T_ROLE_BASE_FUNCTION add constraint FK_RBF_IDBASEFUNCTION_C foreign key (RBF_IDBASEFUNCTION_C) references T_BASE_FUNCTION (BAF_ID_C) on delete restrict on update restrict;
alter table T_ROLE_BASE_FUNCTION add constraint FK_RBF_IDROLE_C foreign key (RBF_IDROLE_C) references T_ROLE (ROL_ID_C) on delete restrict on update restrict;
alter table T_TRACK add constraint FK_TRK_IDALBUM_C foreign key (TRK_IDALBUM_C) references T_ALBUM (ALB_ID_C) on delete restrict on update restrict;
alter table T_TRACK add constraint FK_TRK_IDARTIST_C foreign key (TRK_IDARTIST_C) references T_ARTIST (ART_ID_C) on delete restrict on update restrict;
alter table T_USER add constraint FK_USE_IDLOCALE_C foreign key (USE_IDLOCALE_C) references T_LOCALE (LOC_ID_C) on delete restrict on update restrict;
alter table T_USER add constraint FK_USE_IDROLE_C foreign key (USE_IDROLE_C) references T_ROLE (ROL_ID_C) on delete restrict on update restrict;
alter table T_USER_ALBUM add constraint FK_USA_IDUSER_C foreign key (USA_IDUSER_C) references T_USER (USE_ID_C) on delete restrict on update restrict;
alter table T_USER_ALBUM add constraint FK_USA_IDALBUM_C foreign key (USA_IDALBUM_C) references T_ALBUM (ALB_ID_C) on delete restrict on update restrict;
alter table T_USER_TRACK add constraint FK_UST_IDUSER_C foreign key (UST_IDUSER_C) references T_USER (USE_ID_C) on delete restrict on update restrict;
alter table T_USER_TRACK add constraint FK_UST_IDTRACK_C foreign key (UST_IDTRACK_C) references T_TRACK (TRK_ID_C) on delete restrict on update restrict;
insert into T_CONFIG(CFG_ID_C,CFG_VALUE_C) values('LAST_FM_API_KEY','7119a7b5c4455bbe8196934e22358a27');
insert into T_CONFIG(CFG_ID_C,CFG_VALUE_C) values('LAST_FM_API_SECRET','30dce5dfdb01b87af6038dd36f696f8a');
insert into T_CONFIG(CFG_ID_C, CFG_VALUE_C) values('DB_VERSION', '0');
insert into T_CONFIG(CFG_ID_C, CFG_VALUE_C) values('LUCENE_DIRECTORY_STORAGE', 'FILE');
insert into T_BASE_FUNCTION(BAF_ID_C) values('ADMIN');
insert into T_BASE_FUNCTION(BAF_ID_C) values('PASSWORD');
insert into T_BASE_FUNCTION(BAF_ID_C) values('IMPORT');
insert into T_LOCALE(LOC_ID_C) values('sq_AL');
insert into T_LOCALE(LOC_ID_C) values('sq');
insert into T_LOCALE(LOC_ID_C) values('ar_DZ');
insert into T_LOCALE(LOC_ID_C) values('ar_BH');
insert into T_LOCALE(LOC_ID_C) values('ar_EG');
insert into T_LOCALE(LOC_ID_C) values('ar_IQ');
insert into T_LOCALE(LOC_ID_C) values('ar_JO');
insert into T_LOCALE(LOC_ID_C) values('ar_KW');
insert into T_LOCALE(LOC_ID_C) values('ar_LB');
insert into T_LOCALE(LOC_ID_C) values('ar_LY');
insert into T_LOCALE(LOC_ID_C) values('ar_MA');
insert into T_LOCALE(LOC_ID_C) values('ar_OM');
insert into T_LOCALE(LOC_ID_C) values('ar_QA');
insert into T_LOCALE(LOC_ID_C) values('ar_SA');
insert into T_LOCALE(LOC_ID_C) values('ar_SD');
insert into T_LOCALE(LOC_ID_C) values('ar_SY');
insert into T_LOCALE(LOC_ID_C) values('ar_TN');
insert into T_LOCALE(LOC_ID_C) values('ar_AE');
insert into T_LOCALE(LOC_ID_C) values('ar_YE');
insert into T_LOCALE(LOC_ID_C) values('ar');
insert into T_LOCALE(LOC_ID_C) values('be_BY');
insert into T_LOCALE(LOC_ID_C) values('be');
insert into T_LOCALE(LOC_ID_C) values('bg_BG');
insert into T_LOCALE(LOC_ID_C) values('bg');
insert into T_LOCALE(LOC_ID_C) values('ca_ES');
insert into T_LOCALE(LOC_ID_C) values('ca');
insert into T_LOCALE(LOC_ID_C) values('zh_CN');
insert into T_LOCALE(LOC_ID_C) values('zh_HK');
insert into T_LOCALE(LOC_ID_C) values('zh_SG');
insert into T_LOCALE(LOC_ID_C) values('zh_TW');
insert into T_LOCALE(LOC_ID_C) values('zh');
insert into T_LOCALE(LOC_ID_C) values('hr_HR');
insert into T_LOCALE(LOC_ID_C) values('hr');
insert into T_LOCALE(LOC_ID_C) values('cs_CZ');
insert into T_LOCALE(LOC_ID_C) values('cs');
insert into T_LOCALE(LOC_ID_C) values('da_DK');
insert into T_LOCALE(LOC_ID_C) values('da');
insert into T_LOCALE(LOC_ID_C) values('nl_BE');
insert into T_LOCALE(LOC_ID_C) values('nl_NL');
insert into T_LOCALE(LOC_ID_C) values('nl');
insert into T_LOCALE(LOC_ID_C) values('en_AU');
insert into T_LOCALE(LOC_ID_C) values('en_CA');
insert into T_LOCALE(LOC_ID_C) values('en_IN');
insert into T_LOCALE(LOC_ID_C) values('en_IE');
insert into T_LOCALE(LOC_ID_C) values('en_MT');
insert into T_LOCALE(LOC_ID_C) values('en_NZ');
insert into T_LOCALE(LOC_ID_C) values('en_PH');
insert into T_LOCALE(LOC_ID_C) values('en_SG');
insert into T_LOCALE(LOC_ID_C) values('en_ZA');
insert into T_LOCALE(LOC_ID_C) values('en_GB');
insert into T_LOCALE(LOC_ID_C) values('en_US');
insert into T_LOCALE(LOC_ID_C) values('en');
insert into T_LOCALE(LOC_ID_C) values('et_EE');
insert into T_LOCALE(LOC_ID_C) values('et');
insert into T_LOCALE(LOC_ID_C) values('fi_FI');
insert into T_LOCALE(LOC_ID_C) values('fi');
insert into T_LOCALE(LOC_ID_C) values('fr_BE');
insert into T_LOCALE(LOC_ID_C) values('fr_CA');
insert into T_LOCALE(LOC_ID_C) values('fr_FR');
insert into T_LOCALE(LOC_ID_C) values('fr_LU');
insert into T_LOCALE(LOC_ID_C) values('fr_CH');
insert into T_LOCALE(LOC_ID_C) values('fr');
insert into T_LOCALE(LOC_ID_C) values('de_AT');
insert into T_LOCALE(LOC_ID_C) values('de_DE');
insert into T_LOCALE(LOC_ID_C) values('de_LU');
insert into T_LOCALE(LOC_ID_C) values('de_CH');
insert into T_LOCALE(LOC_ID_C) values('de');
insert into T_LOCALE(LOC_ID_C) values('el_CY');
insert into T_LOCALE(LOC_ID_C) values('el_GR');
insert into T_LOCALE(LOC_ID_C) values('el');
insert into T_LOCALE(LOC_ID_C) values('iw_IL');
insert into T_LOCALE(LOC_ID_C) values('iw');
insert into T_LOCALE(LOC_ID_C) values('hi_IN');
insert into T_LOCALE(LOC_ID_C) values('hu_HU');
insert into T_LOCALE(LOC_ID_C) values('hu');
insert into T_LOCALE(LOC_ID_C) values('is_IS');
insert into T_LOCALE(LOC_ID_C) values('is');
insert into T_LOCALE(LOC_ID_C) values('in_ID');
insert into T_LOCALE(LOC_ID_C) values('in');
insert into T_LOCALE(LOC_ID_C) values('ga_IE');
insert into T_LOCALE(LOC_ID_C) values('ga');
insert into T_LOCALE(LOC_ID_C) values('it_IT');
insert into T_LOCALE(LOC_ID_C) values('it_CH');
insert into T_LOCALE(LOC_ID_C) values('it');
insert into T_LOCALE(LOC_ID_C) values('ja_JP');
insert into T_LOCALE(LOC_ID_C) values('ja_JP_JP');
insert into T_LOCALE(LOC_ID_C) values('ja');
insert into T_LOCALE(LOC_ID_C) values('ko_KR');
insert into T_LOCALE(LOC_ID_C) values('ko');
insert into T_LOCALE(LOC_ID_C) values('lv_LV');
insert into T_LOCALE(LOC_ID_C) values('lv');
insert into T_LOCALE(LOC_ID_C) values('lt_LT');
insert into T_LOCALE(LOC_ID_C) values('lt');
insert into T_LOCALE(LOC_ID_C) values('mk_MK');
insert into T_LOCALE(LOC_ID_C) values('mk');
insert into T_LOCALE(LOC_ID_C) values('ms_MY');
insert into T_LOCALE(LOC_ID_C) values('ms');
insert into T_LOCALE(LOC_ID_C) values('mt_MT');
insert into T_LOCALE(LOC_ID_C) values('mt');
insert into T_LOCALE(LOC_ID_C) values('no_NO');
insert into T_LOCALE(LOC_ID_C) values('no_NO_NY');
insert into T_LOCALE(LOC_ID_C) values('no');
insert into T_LOCALE(LOC_ID_C) values('pl_PL');
insert into T_LOCALE(LOC_ID_C) values('pl');
insert into T_LOCALE(LOC_ID_C) values('pt_BR');
insert into T_LOCALE(LOC_ID_C) values('pt_PT');
insert into T_LOCALE(LOC_ID_C) values('pt');
insert into T_LOCALE(LOC_ID_C) values('ro_RO');
insert into T_LOCALE(LOC_ID_C) values('ro');
insert into T_LOCALE(LOC_ID_C) values('ru_RU');
insert into T_LOCALE(LOC_ID_C) values('ru');
insert into T_LOCALE(LOC_ID_C) values('sr_BA');
insert into T_LOCALE(LOC_ID_C) values('sr_ME');
insert into T_LOCALE(LOC_ID_C) values('sr_CS');
insert into T_LOCALE(LOC_ID_C) values('sr_RS');
insert into T_LOCALE(LOC_ID_C) values('sr');
insert into T_LOCALE(LOC_ID_C) values('sk_SK');
insert into T_LOCALE(LOC_ID_C) values('sk');
insert into T_LOCALE(LOC_ID_C) values('sl_SI');
insert into T_LOCALE(LOC_ID_C) values('sl');
insert into T_LOCALE(LOC_ID_C) values('es_AR');
insert into T_LOCALE(LOC_ID_C) values('es_BO');
insert into T_LOCALE(LOC_ID_C) values('es_CL');
insert into T_LOCALE(LOC_ID_C) values('es_CO');
insert into T_LOCALE(LOC_ID_C) values('es_CR');
insert into T_LOCALE(LOC_ID_C) values('es_DO');
insert into T_LOCALE(LOC_ID_C) values('es_EC');
insert into T_LOCALE(LOC_ID_C) values('es_SV');
insert into T_LOCALE(LOC_ID_C) values('es_GT');
insert into T_LOCALE(LOC_ID_C) values('es_HN');
insert into T_LOCALE(LOC_ID_C) values('es_MX');
insert into T_LOCALE(LOC_ID_C) values('es_NI');
insert into T_LOCALE(LOC_ID_C) values('es_PA');
insert into T_LOCALE(LOC_ID_C) values('es_PY');
insert into T_LOCALE(LOC_ID_C) values('es_PE');
insert into T_LOCALE(LOC_ID_C) values('es_PR');
insert into T_LOCALE(LOC_ID_C) values('es_ES');
insert into T_LOCALE(LOC_ID_C) values('es_US');
insert into T_LOCALE(LOC_ID_C) values('es_UY');
insert into T_LOCALE(LOC_ID_C) values('es_VE');
insert into T_LOCALE(LOC_ID_C) values('es');
insert into T_LOCALE(LOC_ID_C) values('sv_SE');
insert into T_LOCALE(LOC_ID_C) values('sv');
insert into T_LOCALE(LOC_ID_C) values('th_TH');
insert into T_LOCALE(LOC_ID_C) values('th_TH_TH');
insert into T_LOCALE(LOC_ID_C) values('th');
insert into T_LOCALE(LOC_ID_C) values('tr_TR');
insert into T_LOCALE(LOC_ID_C) values('tr');
insert into T_LOCALE(LOC_ID_C) values('uk_UA');
insert into T_LOCALE(LOC_ID_C) values('uk');
insert into T_LOCALE(LOC_ID_C) values('vi_VN');
insert into T_LOCALE(LOC_ID_C) values('vi');
insert into T_ROLE(ROL_ID_C, ROL_NAME_C, ROL_CREATEDATE_D) values('admin', 'Admin', NOW());
insert into T_ROLE_BASE_FUNCTION(RBF_ID_C, RBF_IDROLE_C, RBF_IDBASEFUNCTION_C, RBF_CREATEDATE_D) values('admin_ADMIN', 'admin', 'ADMIN', NOW());
insert into T_ROLE_BASE_FUNCTION(RBF_ID_C, RBF_IDROLE_C, RBF_IDBASEFUNCTION_C, RBF_CREATEDATE_D) values('admin_PASSWORD', 'admin', 'PASSWORD', NOW());
insert into T_ROLE_BASE_FUNCTION(RBF_ID_C, RBF_IDROLE_C, RBF_IDBASEFUNCTION_C, RBF_CREATEDATE_D) values('admin_IMPORT', 'admin', 'IMPORT', NOW());
insert into T_ROLE(ROL_ID_C, ROL_NAME_C, ROL_CREATEDATE_D) values('user', 'User', NOW());
insert into T_ROLE_BASE_FUNCTION(RBF_ID_C, RBF_IDROLE_C, RBF_IDBASEFUNCTION_C, RBF_CREATEDATE_D) values('user_PASSWORD', 'user', 'PASSWORD', NOW());
insert into T_ROLE_BASE_FUNCTION(RBF_ID_C, RBF_IDROLE_C, RBF_IDBASEFUNCTION_C, RBF_CREATEDATE_D) values('user_IMPORT', 'user', 'IMPORT', NOW());
insert into T_USER(USE_ID_C, USE_IDLOCALE_C, USE_IDROLE_C, USE_USERNAME_C, USE_PASSWORD_C, USE_EMAIL_C, USE_FIRSTCONNECTION_B, USE_CREATEDATE_D) values('admin', 'en', 'admin', 'admin', '$2a$05$6Ny3TjrW3aVAL1or2SlcR.fhuDgPKp5jp.P9fBXwVNePgeLqb4i3C', 'admin@localhost', true, NOW());
insert into T_PLAYLIST(PLL_ID_C, PLL_IDUSER_C) values('admin', 'admin');

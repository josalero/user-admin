<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html <#if realm.internationalizationEnabled>lang="${locale.currentLanguageTag}"</#if>>

<head>
  <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons" rel="stylesheet" type="text/css">
  <link href= "https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css" rel= "stylesheet" type="text/css">
  <link href="https://cdn.jsdelivr.net/npm/quasar@2.14.1/dist/quasar.prod.css" rel="stylesheet" type="text/css">
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="robots" content="noindex, nofollow">
  <title>Job Portal Console</title>
  <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
  <link href="${url.resourcesPath}/css/site.css" rel="stylesheet" type="text/css">
  <link href="${url.resourcesPath}/css/main.d511ac97.css" rel="stylesheet" type="text/css">
</head>

<body>
    <#nested "form">
  <!--
    Retrieve Keycloak environement
  -->
  <script id="environment" type="application/json">
    {
      "realm": {
        "resourcesPath": "${url.resourcesPath}",
        "i18n": {
          "enabled": <#if realm.internationalizationEnabled>true<#else>false</#if>,
          "locale": <#if realm.internationalizationEnabled>"${locale.currentLanguageTag}"<#else>null</#if>
        },
        "rememberMe": <#if realm.rememberMe>true<#else>false</#if>
      },
      "user": {
        "username": <#if user??>"${(user.username!'')}"<#else>""</#if>,
        "email": <#if user??>"${(user.email!'')}"<#else>""</#if>,
        "firstName": <#if user??>"${(user.firstName!'')}"<#else>""</#if>,
        "lastName": <#if user??>"${(user.lastName!'')}"<#else>""</#if>
      }
    }
  </script>
  <!-- 
    Use Vue and Quasar with UMD version
    For more information, refer to https://quasar.dev/start/umd#installation
  -->
  <script src="https://cdn.jsdelivr.net/npm/vue@3/dist/vue.global.prod.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/quasar@2.14.1/dist/quasar.umd.prod.js"></script>
  <!-- Install Quasar language pack -->
  <#if realm.internationalizationEnabled>
    <#if properties.locales?has_content>
      <#list properties.locales?split(',') as locale>
        <script src="https://cdn.jsdelivr.net/npm/quasar@2.14.1/dist/lang/${locale}.umd.prod.js"></script>
      </#list>      
    </#if>
    <script>Quasar.lang.set(Quasar.lang.${locale.currentLanguageTag})</script>
  </#if>
  <script src="${url.resourcesPath}/js/config.js"></script>
  <script src="${url.resourcesPath}/js/quasar.js"></script>
</body>
</html>
</#macro>
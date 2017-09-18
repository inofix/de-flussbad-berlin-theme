<#--
    share_buttons.ftl: social_media.ftl is a template which displays
    social-media-buttons with the shariff.js (which is imported via
    the social-media-portlet). It can be included by any freemarker
    template.

    Created:    2015-11-01 11:41 by Christian Berndt
    Modified:   2017-04-04 14:52 by Christian Berndt
    Version:    1.0.6

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->

<#function value_of docXml field language_id>
    <#local default_language_id = docXml.valueOf("/root/@default-locale") />
    <#local value = docXml.valueOf("//dynamic-element[@name='" + field + "']/dynamic-content[@language-id='"+ language_id + "']/text()") />
    <#if !value?has_content>
        <#local value = docXml.valueOf("//dynamic-element[@name='" + field + "']/dynamic-content[@language-id='"+ default_language_id + "']/text()") />
    </#if>
    <#return value />
</#function>

<#assign language_id = languageUtil.getLanguageId(locale) />

<#assign articleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleService") />
<#assign articleId = getterUtil.getString(.vars['reserved-article-id'].data) />
<#assign article = articleService.getArticle(groupId, articleId) />
<#assign docXml = saxReaderUtil.read(article.content) />
<#assign title = value_of(docXml, "title", language_id) />
<#assign headline = value_of(docXml, "headline", language_id) />
<#if headline?has_content>
    <#assign title = headline />
</#if>
<#assign summary = value_of(docXml, "summary", language_id) />
<#assign teaser = value_of(docXml, "teaser", language_id) />
<#if teaser?has_content>
    <#assign summary = teaser />
</#if>
<#assign keyVisual = value_of(docXml, "keyVisual", language_id) />

<#assign currentURL = "" />
<#if request.attributes??>
    <#if request.attributes['CURRENT_COMPLETE_URL']??>
        <#assign currentURL = request.attributes['CURRENT_COMPLETE_URL'] />
    </#if>
</#if>

<#assign protocol = "http" />
<#if currentURL?starts_with("https")>
    <#assign protocol = "https" />
</#if>

<#assign serverName = "www.flussbad-berlin.de" /> 
<#assign picture = protocol + "://" + serverName + "/documents/41139/46318/05_Flussbad_Berlin_Log_Mit_Plan.png/30fcb9f2-f81b-446f-8e8a-9ffe01a3e049?version=1.1&t=1481636347608&download=true" />
<#if keyVisual?has_content>
    <#assign picture = protocol + "://" + serverName +  keyVisual />
</#if>


<#assign shareURL = "" />

<#assign backendUrl = protocol + "://" + serverName + "/shariff" /> 

<#assign shareURL = currentURL />
<#assign shareURL = httpUtil.removeParameter(shareURL, "inheritRedirect") />
<#assign shareURL = httpUtil.removeParameter(shareURL, "redirect") />
<#assign mailBody = "Schau mal hier auf www.flussbad-berlin.de" /> 
<#assign mailSubject = "Schau mal auf www.flussbad-berlin.de" />
<#assign mailUrl = "mailto:" /> 
<#assign selectedOrientation = "horizontal" />
<#assign servicesConfig = "[&quot;facebook&quot;,&quot;twitter&quot;,&quot;mail&quot;]" />
<#assign selectedTheme = "standard" />
<#assign twitterVia = "flussbad" />

<div class="social-media">

    <span class="tell-others"><@liferay.language key="tell-others" /></span>

    <div class="shariff" 
        data-fb-api-key="755224881300786"
        data-fb-description="${summary}"
        data-fb-name="${title}"
        data-fb-picture="${picture}"
        data-backend-url="${backendUrl}"
        data-url="${shareURL}" 
        data-mail-body="${mailBody}"
        data-mail-subject="${mailSubject}" 
        data-mail-url="${mailUrl}"
        data-orientation="${selectedOrientation}"
        data-services="${servicesConfig}"
        data-theme="${selectedTheme}" 
        data-twitter-via="${twitterVia}">
    </div>
    
</div> <#-- / .social-media -->

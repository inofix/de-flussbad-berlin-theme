<#--
    event_list_small.ftl: Display a small list of events.
    
    Created:    2017-09-14 16:23 by Christian Berndt
    Modified:   2017-09-19 00:29 by Christian Berndt
    Version:    1.0.1
-->

<#assign journalArticleService = serviceLocator.findService("com.liferay.journal.service.JournalArticleLocalService")>

<#assign language_id = languageUtil.getLanguageId(locale) />

<#function value_of docXml field language_id>
    <#local default_language_id = docXml.valueOf("/root/@default-locale") />
    <#local value = docXml.valueOf("//dynamic-element[@name='" + field + "']/dynamic-content[@language-id='"+ language_id + "']/text()") />
    <#if !value?has_content>
        <#local value = docXml.valueOf("//dynamic-element[@name='" + field + "']/dynamic-content[@language-id='"+ default_language_id + "']/text()") />
    </#if>
    <#return value />
</#function>

<div class="events-small" >
    <#if entries?has_content>
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <h3><@liferay.language key="events" /></h3>
                    <h1><@liferay.language key="the-most-important-events" /></h1>
                </div>
            </div>
            <#list entries as curEntry>
                <div class="row">
                
                    <#assign content = "" />
                    
                    <#if "com.liferay.journal.model.JournalArticle" == curEntry.className >
                        <#assign article = journalArticleService.getLatestArticle(curEntry.getClassPK()) />
                        <#assign xml = saxReaderUtil.read(article.content) />
                        <#assign title = value_of(xml, "title", language_id) />
                        <#assign date = value_of(xml, "date", language_id) />
                        
                        <div class="col-sm-10 col-sm-offset-1">
                            <h2 class="date">${date} _ </h2>
                            <h2 class="title">${title}</h2>
                        </div>
    
                    <#else>
                        <span class="alert alert-danger"><strong>${curEntry.className}</strong> is not supported by the event_list_small display template.</alert>
                    </#if>
                </div>
            </#list>
        </div>
    </#if>
</div>

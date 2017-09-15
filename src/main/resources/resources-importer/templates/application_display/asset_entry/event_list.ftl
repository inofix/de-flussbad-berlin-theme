<#--
    event_list.ftl: Display a list of events.
    
    Created:    2017-09-14 16:23 by Christian Berndt
    Modified:   2017-09-15 23:04 by Christian Berndt
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

<div class="events" >
    <#if entries?has_content>
        <div class="container">
            <#list entries as curEntry>
                <div class="row">
                
                    <#assign content = "" />
                    
                    <#if "com.liferay.journal.model.JournalArticle" == curEntry.className >
                        <#assign article = journalArticleService.getLatestArticle(curEntry.getClassPK()) />
                        <#assign xml = saxReaderUtil.read(article.content) />
                        <#assign date = value_of(xml, "date", language_id) />
                        <#assign location = value_of(xml, "location", language_id) />
                        <#assign summary = value_of(xml, "summary", language_id) />
                        <#assign title = value_of(xml, "title", language_id) />
                        
                        <div class="col-sm-4">
                            <div class="date">${date}</div>
                            <#if location?has_content>
                                <div class="location">${location}</div>
                            </#if>
                        </div>
                        
                        <div class="event col-sm-8">
                            <h2><span class="title">${title}</span></h2>
                            <#if summary?has_content>
                                <div class="summary">${summary}</div>
                            </#if>
                        </div>
    
                    <#else>
                        <span class="alert alert-danger"><strong>${curEntry.className}</strong> is not supported by the event_list display template.</alert>
                    </#if>
                </div>
            </#list>
        </div>
    </#if>
</div>

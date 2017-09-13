<#--
    statements.ftl: Display a list of statements in a scrollview-carousel.
    
    Created:    2015-10-13 18:27 by Christian Berndt
    Modified:   2017-09-13 22:27 by Christian Berndt
    Version:    1.0.6
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


<#assign cssClass = "gray-green">

<div id="statements-carousel" class="carousel slide statements ${cssClass}" data-ride="carousel">
    <#if entries?has_content>
        <div class="container"> 
            <div class="carousel-inner" role="listbox">  
                <#list entries as curEntry>
                
                    <#assign cssClass = ""/>
                    <#if curEntry?is_first>
                        <#assign cssClass = "active"/>                   
                    </#if>
                    <div class="item ${cssClass}">
        
                        <#assign content = "" />
                        
                        <#if "com.liferay.journal.model.JournalArticle" == curEntry.className >
                            <#assign article = journalArticleService.getLatestArticle(curEntry.getClassPK()) />
                            <#assign xml = saxReaderUtil.read(article.content) />
                            <#assign author = value_of(xml, "author", language_id) />
                            <#assign statement = value_of(xml, "statement", language_id) />
                            
                            <div class="statement">
                                <blockquote>${statement}</blockquote>
                                <cite class="author pull-right">${author}</cite>
                            </div>
        
                        <#else>
                            <span class="alert alert-danger"><strong>${curEntry.className}</strong> is not supported by the statements display template.</alert>
                        </#if>
                        
                    </div>
                </#list>
            </div>
        </div>
    </#if>
</div>

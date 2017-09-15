<#--
    press_release.ftl: Format the press-release structure
    
    Created:    2017-09-15 23:32 by Christian Berndt
    Modified:   2017-09-15 23:32 by Christian Berndt
    Version:    1.0.0
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->
<div class="press-release">
    <h2>${title.getData()}</h2>
    <#assign date_Data = getterUtil.getString(date.getData())>

    <#if validator.isNotNull(date_Data)>
        <#assign date_DateObj = dateUtil.parseDate("yyyy-MM-dd", date_Data, locale)>
    
        ${dateUtil.getDate(date_DateObj, "dd MMM yyyy - HH:mm:ss", locale)}
    </#if>
    <div class="location">${location.getData()}</div>
    <div class="summary">${summary.getData()}</div>
    <div class="section">${section.getData()}</div>
    
</div>
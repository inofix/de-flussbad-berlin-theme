<#--
    media_gallery.ftl: Loop over a list of asset-entries and
    format them in as a gallery.
    
    Created:    2016-04-16 13:07 by Christian Berndt
    Modified:   2016-09-07 18:53 by Christian Berndt
    Version:    1.1.0
-->

<#assign fileEntryService  = serviceLocator.findService("com.liferay.portlet.documentlibrary.service.DLFileEntryLocalService") />
<#assign journalArticleService = serviceLocator.findService("com.liferay.portlet.journal.service.JournalArticleLocalService") />

<#assign namespace = renderResponse.namespace />
<#assign current_url = portalUtil.getCurrentURL(request) />
<#assign path_friendly_url = themeDisplay.pathFriendlyURLPublic />
<#assign layout = themeDisplay.layout />
<#assign group_url = layout.group.friendlyURL />       

<#assign path_and_group_url = path_friendly_url + group_url />

<#-- with virtualhost configured -->
<#assign prefix = "" />

<#-- without virtualhost configured -->
<#if current_url?starts_with(path_friendly_url)>
    <#assign prefix = path_and_group_url />
</#if>    

<#assign layout_url = prefix + layout.friendlyURL />

<#assign filteredEntries = [] />

<#list entries as entry>
    
    <#assign entry = entry />
    <#assign assetRenderer = entry.assetRenderer />
    <#assign className = assetRenderer.className />              
    
    <#if "com.liferay.portlet.journal.model.JournalArticle" == className >
    
        <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContent()) />
        
        <#assign service = docXml.valueOf("//dynamic-element[@name='service']/dynamic-content/text()") />
        <#assign url = docXml.valueOf("//dynamic-element[@name='url']/dynamic-content/text()") />
          
        <#if url?has_content>
        
            <#assign filteredEntries = filteredEntries + [entry] />
                            
        </#if>
        
    <#elseif "com.liferay.portlet.documentlibrary.model.DLFileEntry" == className >

        <#assign fileEntry = fileEntryService.getFileEntry(entry.classPK) />
        
        <#assign formats = ["gif", "jpg", "png", "tif"] />
        
        <#list formats as format>
        
            <#if fileEntry.extension?lower_case == format >
    
                <#assign filteredEntries = filteredEntries + [entry] />
                
            </#if>
        
        </#list>
           
    </#if>
    
</#list>

<!-- Modal slideshow -->
<div class="modal slideshow fade" id="${namespace}modalSlideshow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <div id="${namespace}slider" class="flexslider">
                    <ul class="slides">
                                    
                        <#if filteredEntries?has_content>
                                                 
                            <#assign i = 1 /> 
                                            
                            <#list filteredEntries as entry>
                            
                                <li class="item">
                            
                                    <#assign entry = entry />
                                    <#assign assetRenderer = entry.assetRenderer />
                                    <#assign className = assetRenderer.className />              
                                
                                    <#if "com.liferay.portlet.journal.model.JournalArticle" == className >
                                                                            
                                        <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContent()) />
                                        
                                        <#assign service = docXml.valueOf("//dynamic-element[@name='service']/dynamic-content/text()") />
                                        <#assign url = docXml.valueOf("//dynamic-element[@name='url']/dynamic-content/text()") />
                                       
                                        <#assign viewURL = ""/>
                                        <#assign assetRenderer = entry.getAssetRenderer() />
                                        
                                        <#if assetRenderer.getURLViewInContext(renderRequest, renderResponse, null)?? >                     
                                            <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, null) />
                                        <#else>
                                            <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />                        
                                        </#if>
                                        
                                        <#if url?has_content>
                                        
                                            <#assign config = "&format=json" />    
                                            <#assign embed_url = service + url + config />
                                            <#assign embed_url = httpUtil.encodeURL(embed_url) />
                                            <div class="video-wrapper">
                                                <div id="${namespace}_${i}_video" class="video">&nbsp;</div> 
                                            </div>                            
                                        <#else>
                                            <div class="none">
                                                Only structures of type "Video" can be displayed
                                                in the Media Gallery.
                                            </div>
                                        </#if>
                                    
                                    <#elseif "com.liferay.portlet.documentlibrary.model.DLFileEntry" == className >
                    
                                        <#assign fileEntry = fileEntryService.getFileEntry(entry.classPK) />                
                                        <#assign latestFileVersion = fileEntry.getFileVersion() />
                                        <#assign latestFileVersionStatus = latestFileVersion.getStatus() />
                                        <#assign fileTitle = httpUtil.encodeURL(htmlUtil.unescape(latestFileVersion.getTitle())) />
                                    
                                        <#assign imgSrc = "/documents/" + groupId + "/" + fileEntry.folder.folderId + "/" + fileTitle /> 
                                        <#assign caption = latestFileVersion.getDescription() />
                                        
                                        <div class="image-wrapper">
                                            <img src="${imgSrc}?imageThumbnail=3" />
                                            <#if caption?has_content >
                                                <div class="caption" style="display: none;">${caption}</div>
                                            </#if>                                
                                        </div>
                                        
                                    <#else>
                                        <div class="none">
                                            This is neither a video nor a document.  
                                        </div>              
                                    </#if>
                                    
                                    <#assign i = i+1 /> 
                                
                                </li>                   
                    
                            </#list>
                        </#if>
                    </ul>
                </div>                                        
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="template gallery media span8">
        <#if themeDisplay.portletDisplay.title?has_content >
            <h3>${themeDisplay.portletDisplay.title}</h3>
        </#if> 
        <#if filteredEntries?has_content>                          
            <#assign i = 1 /> 
            
            <div class="row-fluid">          
                
            <#list filteredEntries as entry>
            
                <div class="span6">
            
                <#assign entry = entry />
                <#assign assetRenderer = entry.assetRenderer />
                <#assign className = assetRenderer.className />              
            
                <#if "com.liferay.portlet.journal.model.JournalArticle" == className >
                                    
                    <#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContent()) />
                    
                    <#assign service = docXml.valueOf("//dynamic-element[@name='service']/dynamic-content/text()") />
                    <#assign url = docXml.valueOf("//dynamic-element[@name='url']/dynamic-content/text()") />
                   
                    <#assign viewURL = ""/>
                    <#assign assetRenderer = entry.getAssetRenderer() />
                    
                    <#if assetRenderer.getURLViewInContext(renderRequest, renderResponse, null)?? >                     
                        <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, null) />
                    <#else>
                        <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />                        
                    </#if>
                    
                    <#if url?has_content>
                    
                        <#assign config = "&format=json" />    
                        <#assign embed_url = service + url + config />
                        <#assign embed_url = httpUtil.encodeURL(embed_url) />
                                                
                        <a href="javascript:;" data-toggle="modal" data-target="#${namespace}modalSlideshow" data-index="${i}">
                        
                            <div id="${namespace}_${i}_video_thumbnail" class="video-wrapper">
                                <#-- <span class="icon-youtube-play"></span> -->
                                <span class="icon icon-play-sign"></span>
                            </div>
                        </a>
                                                    
                        <script>
                        <!--       
                            var ${namespace}_${i}_oEmbedURL = "${layout_url}?p_p_id=proxyportlet_WAR_proxyportlet&p_p_lifecycle=2&_proxyportlet_WAR_proxyportlet_embedURL= ${embed_url}";
                                                                         
                            $( document ).ready(function() {            
                                ${namespace}_${i}_loadFrame();            
                            });
                            
                            function ${namespace}_${i}_loadFrame() {
                            
                                /**
                                 * oEmbed
                                 */
                                $.get( ${namespace}_${i}_oEmbedURL, function( str ) {

                                    var data = JSON.parse(str);
                                    var html = data.html;
                                    var provider_name = data.provider_name;
                                    var thumbnail_url = data.thumbnail_url;
                                    var title = data.title;
                                                                        
                                    var videoHeight = data.height; 
                                    var videoWidth = data.width;
                                            
                                    var scale = 0.9;
                                    var buttonWidth = 40;
                                                                         
                                    var boxWidth = $(window).width() * scale - buttonWidth;
                                    var boxHeight = $(window).height() * scale; 
                                    var boxRatio = boxWidth / boxHeight;                                   
                                                                         
                                    // set the size of the embedded video iframes
                                    var width = boxWidth;
                                    var height = boxHeight;
                                                                                                               
                                    // preserve the videos ratio 
                                    var videoRatio = videoWidth / videoHeight;                                   
                                    
                                    if (videoRatio > boxRatio) {
                                        width = boxWidth;
                                        var ratio = videoWidth / boxWidth; 
                                        height = videoHeight / ratio;
                                    } else {
                                        height = boxHeight;
                                        var ratio = videoHeight / boxHeight; 
                                        width = videoWidth / ratio;
                                    }                                
                                                                        
                                    html = html.replace(videoWidth, width); 
                                    html = html.replace(videoHeight, height);
                                     
                                    // load the thumbnail into the gallery
                                    var style = 'background-image: url("' +  thumbnail_url + '");';                                                    
                                    $("#${namespace}_${i}_video_thumbnail").attr("style", style);
                                    
                                    // insert the title as a caption after the video-wrapper
                                    var caption = '<div class="caption">' + title + '</div>'; 
                                    $(caption).insertAfter($("#${namespace}_${i}_video_thumbnail")); 
                                    
                                    // and load the video frame into the slider                 
                                    $("#${namespace}_${i}_video").html(html);                  
                                         
                                });          
                            };        
                        -->
                        </script> 
                    
                    <#else>
                        <div class="none">
                            Only structures of type "Video" can be displayed
                            in the Media Gallery.
                        </div>
                    </#if>
                
                <#elseif "com.liferay.portlet.documentlibrary.model.DLFileEntry" == className >
                
                    <#assign fileEntry = fileEntryService.getFileEntry(entry.classPK) />
                    <#assign latestFileVersion = fileEntry.getFileVersion() />
                    <#assign latestFileVersionStatus = latestFileVersion.getStatus() />
                    <#assign title = httpUtil.encodeURL(htmlUtil.unescape(latestFileVersion.getTitle())) />
                
                    <#assign style = "background-image: url('/documents/" + groupId + "/" + fileEntry.folder.folderId + "/" + title + "?imageThumbnail=3');" /> 
                    <#assign caption = latestFileVersion.getDescription() />              
                    <#assign downloadURL = "/documents/" + groupId + "/" + fileEntry.folder.folderId + "/" + title + "?download=true" />            
                                    
                    <a href="javascript:;" data-toggle="modal" data-target="#${namespace}modalSlideshow" data-index="${i}">
                        <div class="image-wrapper" style="${style}">&nbsp;</div>                     
                    </a> 
                    <#if caption?has_content >
                        <span class="caption">${caption}</span>
                    </#if>                     
                    <a href="${downloadURL}" title="<@liferay.language key="download" />" class="download"><span class="icon icon-download"></span></a>
                <#else>
                
                    <div class="none">This is neither a video nor a document.</div>
                   
                </#if>
                
                </div> <#-- /.span6 -->           
                
                <#if i%2 == 0 && i gt 0 >
                    </div>
                    <div class="row-fluid">
                </#if>
                
                <#assign i = i+1 />                    
    
            </#list>
            
            </div> <#-- / .row-fluid -->
            
        <#else>
            <div class="alert alert-info"><@liferay.language key="there-are-no-results" /></div>
        </#if> 
        
        <script>
            /**
             * Move the slider in the modalSlideshow to the current image.
             */
            $(document).on('shown.bs.modal', function(event) {
                    
                var button = $(event.relatedTarget); // Button that triggered the modal     
                var index = button.data('index');
                
                console.log('shown.bs.modal'); 
                console.log('index = ' + index); 
        
                var slider = $('#${namespace}slider').data('flexslider');
                
                console.log(slider); 
                
                slider.flexAnimate(index - 1);
        
            });        
        </script>
                     
    </div> <#-- /.media .span8 -->
</div> <#-- /.container -->

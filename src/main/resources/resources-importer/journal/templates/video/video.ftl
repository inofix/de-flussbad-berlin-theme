<#--
    video.ftl: Format the video structure

    Created:    2016-04-06 21:32 by Christian Berndt
    Modified:   2016-04-14 13:43 by Christian Berndt
    Version:    1.0.2

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->

<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService") />

<#if request['theme-display']??>

    <#assign current_url = request.attributes['CURRENT_URL']/>
    <#assign displayFullscreen = false />
    <#assign group_url = "" />
    <#assign theme_display = request['theme-display'] />
    <#assign namespace = request['portlet-namespace'] />
    <#assign path_friendly_url = theme_display['path-friendly-url-public'] />   
    <#assign path_and_group_url = path_friendly_url + group_url />
    <#assign plid = theme_display['plid'] />
    <#assign proxy_ns = "proxyportlet_WAR_proxyportlet" />
    
    <#if fullscreen?? >
        <#if fullscreen.getData()?has_content>
            <#if getterUtil.getBoolean(fullscreen.getData())>
                <#assign displayFullscreen = getterUtil.getBoolean(fullscreen.getData()) />
            </#if>
        </#if>
    </#if>
    
    <#if plid?number gt 0 >
        <#assign layout = layoutLocalService.getLayout(plid?number) />
        <#assign group_url = layout.group.friendlyURL />       
    </#if>
    
    <#assign path_and_group_url = path_friendly_url + group_url />
    
    <#-- with virtualhost configured -->
    <#assign prefix = "" />
    
    <#-- without virtualhost configured -->
    <#if current_url?starts_with(path_friendly_url)>
        <#assign prefix = path_and_group_url />
    </#if>    
    
    <#assign layout_url = prefix + layout.friendlyURL />
    
    <div style="margin-top: 100px;">
    	video.ftl v.1
    </div>
    
    
    <#if displayFullscreen>
        <div id="${namespace}_video">&nbsp;</div>
    <#else>
        <div class="container">
            <div id="${namespace}_video">&nbsp;</div>
        </div>    
    </#if>    
        
    <#assign config = "&format=json" />    
    <#assign embed_url = service.getData() + url.getData() + config />
    <#assign embed_url = httpUtil.encodeURL(embed_url) />
    
    <script>
    <!--       
        var oEmbedURL = "${layout_url}?p_p_id=proxyportlet_WAR_proxyportlet&p_p_lifecycle=2&_proxyportlet_WAR_proxyportlet_embedURL= ${embed_url}";
         
        var fullscreen = false;
         
        <#if displayFullscreen>
           fullscreen = true;
        </#if>        
        
        $( document ).ready(function() {            
            loadFrame();            
        });
        
        function loadFrame() {
        
            /**
             * oEmbed
             */
            $.get( oEmbedURL, function( str ) {
            
                 var data = JSON.parse(str);
                 var html = data.html;
                 var videoHeight = data.height; 
                 var videoWidth = data.width; 
                 
                 var windowWidth = $(window).width();
                 
                 // set size of youtube iframe (default 480 x 270)
                 var width = windowWidth; 
                                  
                 if (!fullscreen) {
                    
                     width = 1170;              // bootstrap container
                     
                     if (windowWidth < 1200) {
                         width = 940;           // bootstrap container
                     }
                     if (windowWidth < 980) {
                        width = 724;            // bootstrap container
                     }                     
                     if (windowWidth < 768) {
                        width = windowWidth;    // bootstrap container
                     }                     
                     
                 }                 
                 
                 // set width of vimeo iframe
                 html = html.replace("1280", "100%");       // vimeo
                 
                 var height = (width / 16) * 9;
                 
                 // youtube sizes its videos with the iframe
                 html = html.replace(videoWidth, width);        // youtube default width
                 html = html.replace(videoHeight, height);      // youtube default height
                                  
                 $("#${namespace}_video").html(html);                  
                     
            });          
        };        
    -->
    </script>

</#if>
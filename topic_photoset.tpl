{assign var="oBlog" value=$oTopic->getBlog()}
{assign var="oUser" value=$oTopic->getUser()}
{assign var="oVote" value=$oTopic->getVote()}

<script type="text/javascript">
jQuery(window).load(function($) {
	ls.photoset.showMainPhoto({$oTopic->getId()});
});
</script>

<div class="topic photo">
	<h2 class="title">
		{if $oTopic->getPublish()==0}   
			<img src="{cfg name='path.static.skin'}/images/draft.png" title="{$aLang.topic_unpublish}" alt="{$aLang.topic_unpublish}" />
		{/if}
		<a href="{$oTopic->getUrl()}" class="title-topic">{$oTopic->getTitle()|escape:'html'}</a>
	</h2>
       
    
	<p class="info-short">
		{$aLang.topic_pub} <a href="{router page='archive'}{date_format format="Y" date=$oTopic->getDateAdd()}/{date_format format="m" date=$oTopic->getDateAdd()}/{date_format format="d" date=$oTopic->getDateAdd()}/" class="title-topic" title="{date_format date=$oTopic->getDateAdd() format="H:i"}">{date_format date=$oTopic->getDateAdd() format="j F Y"}</a> {$aLang.topic_by} <a href="{router page='my'}{$oUser->getLogin()}/">{$oUser->getLogin()}</a>
	</p>
       
       
       
        <ul class="actions">                                                                   
                {if $oUserCurrent and ($oUserCurrent->getId()==$oTopic->getUserId() or $oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() or $oBlog->getUserIsModerator() or $oBlog->getOwnerId()==$oUserCurrent->getId())}
                        <li><a href="{cfg name='path.root.web'}/{$oTopic->getType()}/edit/{$oTopic->getId()}/" title="{$aLang.topic_edit}" class="edit">{$aLang.topic_edit}</a></li>
                {/if}
                {if $oUserCurrent and ($oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() or $oBlog->getOwnerId()==$oUserCurrent->getId())}
                        <li><a href="{router page='topic'}delete/{$oTopic->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" title="{$aLang.topic_delete}" onclick="return confirm('{$aLang.topic_delete_confirm}');" class="delete">{$aLang.topic_delete}</a></li>
                {/if}
        </ul>

    
	<!-- Topic Photo Preview -->
	<div class="topic-photo-preview" id="photoset-main-preview-{$oTopic->getId()}">
        {assign var=oMainPhoto value=$oTopic->getPhotosetMainPhoto()}
		<div class="topic-photo-count" id="photoset-photo-count-{$oTopic->getId()}" onclick="window.location='{$oTopic->getUrl()}#photoset'">{$oTopic->getPhotosetCount()} {$aLang.topic_photoset_photos}</div>
		{if $oMainPhoto->getDescription()}
			<div class="topic-photo-desc" id="photoset-photo-desc-{$oTopic->getId()}">{$oMainPhoto->getDescription()}</div>
		{/if}
		<img src="{$oMainPhoto->getWebPath(500)}" alt="image" id="photoset-main-image-{$oTopic->getId()}" />
	</div>
	<!-- /Topic Photo Preview -->

	{assign var=iPhotosCount value=$oTopic->getPhotosetCount()}
	<div class="content">
		{if $bTopicList}
			{$oTopic->getTextShort()}
			{if $oTopic->getTextShort()!=$oTopic->getText()}
				<br /><a href="{$oTopic->getUrl()}#cut" title="{$aLang.topic_read_more}">
				{if $oTopic->getCutText()}
					{$oTopic->getCutText()}
				{else}
					{$aLang.topic_photoset_show_all|ls_lang:"COUNT%%`$iPhotosCount`"} &rarr;
				{/if}                           
				</a>
			{/if}
		{else}
			{$oTopic->getText()}
		{/if}
	</div> 

        <!-- Topic Photo Image List -->
	{if !$bTopicList}
		<script type="text/javascript" src="{cfg name='path.root.engine_lib'}/external/prettyPhoto/js/prettyPhoto.js"></script>	
		<link rel='stylesheet' type='text/css' href="{cfg name='path.root.engine_lib'}/external/prettyPhoto/css/prettyPhoto.css" />
		<script type="text/javascript">
		    jQuery(document).ready(function($) {	
		        $('.photoset-image').prettyPhoto({
		               social_tools:'',
		               show_title: false,
		               slideshow:false,
		               deeplinking: false
		        });
		    });
		</script>
		
		
		<div class="topic-photo-images">
			<h2>{$oTopic->getPhotosetCount()} {$oTopic->getPhotosetCount()|declension:$aLang.topic_photoset_count_images}</h2>
			<a name="photoset"></a>
			<ul id="topic-photo-images" >
                            {assign var=aPhotos value=$oTopic->getPhotosetPhotos(0, $oConfig->get('module.topic.photoset.per_page'))}
                            {if count($aPhotos)}                                
                                {foreach from=$aPhotos item=oPhoto}
                                    <li><a class="photoset-image" href="{$oPhoto->getWebPath(1000)}" rel="[photoset]"  title="{$oPhoto->getDescription()}"><img src="{$oPhoto->getWebPath('50crop')}" alt="{$oPhoto->getDescription()}" /></a></li>                                    
                                    {assign var=iLastPhotoId value=$oPhoto->getId()}
                                {/foreach}
                            {/if}
                            <script type="text/javascript">
                            	ls.photoset.idLast='{$iLastPhotoId}';
                            </script>
			</ul>
			{if count($aPhotos)<$oTopic->getPhotosetCount()}
				<a href="javascript:ls.photoset.getMore({$oTopic->getId()})" id="topic-photo-more" class="topic-photo-more">{$aLang.topic_photoset_show_more} &darr;</a>
			{/if}
		</div>
	{/if}
	<!-- /Topic Photo Image List -->




	<div class="info">
		{if $oBlog->getType()!='personal'}
			{$aLang.topic_pub_in} <a href="{$oBlog->getUrlFull()}" class="title-blog">{$oBlog->getTitle()|escape:'html'}</a> | 
		{/if}
		
		{$aLang.topic_tags}: 
		{foreach from=$oTopic->getTagsArray() item=sTag name=tags_list}
			<a href="{router page='tag'}{$sTag|escape:'html'}/">{$sTag|escape:'html'}</a>{if !$smarty.foreach.tags_list.last}, {/if}
		{/foreach}	
		
		{if !$tSingle}
			| <span class="comments-link">
				<a href="{$oTopic->getUrl()}#comments" title="{$aLang.topic_comment_read}">{$aLang.topic_comments}: 
				{if $oTopic->getCountComment()>0}
					{$oTopic->getCountComment()} <span>{if $oTopic->getCountCommentNew()}+{$oTopic->getCountCommentNew()}{/if}</span>
				{else}{$aLang.topic_comments_no}{/if}</a></span>
		{/if}

		{if $oTopic->getType()=='link'}
			&nbsp;<a href="{router page='link'}go/{$oTopic->getId()}/" title="{$aLang.topic_link_count_jump} {$oTopic->getLinkCountJump()}" class="link">{$oTopic->getLinkUrl(true)}</a>
		{/if}							
		
		{hook run='topic_show_info' topic=$oTopic}
	</div>
        {if !$bTopicList}
                {hook run='topic_show_end' topic=$oTopic}
        {/if}
</div>
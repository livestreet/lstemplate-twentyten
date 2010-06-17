{assign var="oBlog" value=$oTopic->getBlog()}
{assign var="oUser" value=$oTopic->getUser()}
{assign var="oVote" value=$oTopic->getVote()} 


<div class="topic">
	<h2 class="title">
		{if $oTopic->getPublish()==0}	
			<img src="{cfg name='path.static.skin'}/images/draft.png" title="{$aLang.topic_unpublish}" alt="{$aLang.topic_unpublish}" />
		{/if}
		{if $oTopic->getType() == 'link'}<img src="{cfg name='path.static.skin'}/images/topic_link.png" title="{$aLang.topic_link}" alt="{$aLang.topic_link}" />{/if}
		<a href="{if $oTopic->getType()=='link'}{router page='link'}go/{$oTopic->getId()}/{else}{$oTopic->getUrl()}{/if}" class="title-topic">{$oTopic->getTitle()|escape:'html'}</a>
	</h2>
	
	
	<p class="info-short">{$aLang.topic_pub} <a href="{if $oTopic->getType()=='link'}{router page='link'}go/{$oTopic->getId()}/{else}{$oTopic->getUrl()}{/if}" class="title-topic" title="{date_format date=$oTopic->getDateAdd() format="H:i"}">{date_format date=$oTopic->getDateAdd() format="j F Y"}</a> {$aLang.topic_by} <a href="{router page='my'}{$oUser->getLogin()}/">{$oUser->getLogin()}</a></p>
	
	
	{if $oUserCurrent}
		<ul class="actions">									
			{if $oUserCurrent and ($oUserCurrent->getId()==$oTopic->getUserId() or $oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() or $oBlog->getUserIsModerator() or $oBlog->getOwnerId()==$oUserCurrent->getId())}
				<li><a href="{cfg name='path.root.web'}/{$oTopic->getType()}/edit/{$oTopic->getId()}/" title="{$aLang.topic_edit}" class="edit">{$aLang.topic_edit}</a></li>
			{/if}
			{if $oUserCurrent and ($oUserCurrent->isAdministrator() or $oBlog->getUserIsAdministrator() or $oBlog->getOwnerId()==$oUserCurrent->getId())}
				<li><a href="{router page='topic'}delete/{$oTopic->getId()}/?security_ls_key={$LIVESTREET_SECURITY_KEY}" title="{$aLang.topic_delete}" onclick="return confirm('{$aLang.topic_delete_confirm}');" class="delete">{$aLang.topic_delete}</a></li>
			{/if}
		</ul>
	{/if}


	<div class="content">
		{if $oTopic->getType()=='question'}
			<div id="topic_question_area_{$oTopic->getId()}" class="poll">
				{if !$oTopic->getUserQuestionIsVote()}
					<ul class="poll-vote">
						{foreach from=$oTopic->getQuestionAnswers() key=key item=aAnswer}
							<li><label><input type="radio" id="topic_answer_{$oTopic->getId()}_{$key}" name="topic_answer_{$oTopic->getId()}" value="{$key}" onchange="$('topic_answer_{$oTopic->getId()}_value').setProperty('value',this.value);" /> {$aAnswer.text|escape:'html'}</label></li>
						{/foreach}
					</ul>

					<input type="submit" value="{$aLang.topic_question_vote}" onclick="ajaxQuestionVote({$oTopic->getId()},$('topic_answer_{$oTopic->getId()}_value').getProperty('value'));" />
					<input type="submit" value="{$aLang.topic_question_abstain}" onclick="ajaxQuestionVote({$oTopic->getId()},-1)" />
					<input type="hidden" id="topic_answer_{$oTopic->getId()}_value" value="-1" />
				{else}
					{include file='topic_question.tpl'}
				{/if}
			</div>
		{/if}

		{if !$tSingle}
			{$oTopic->getTextShort()}
			{if $oTopic->getTextShort()!=$oTopic->getText()}
				<a href="{$oTopic->getUrl()}" title="{$aLang.topic_read_more}">
				{if $oTopic->getCutText()}
					{$oTopic->getCutText()}
				{else}
					{$aLang.topic_read_more}
				{/if}      			
				</a>
			{/if}
		{else}
			{$oTopic->getText()}
		{/if}
	</div>	
	
	
	
	{if $tSingle}
		<div class="author-info">
			<a href="{$oUser->getUserWebPath()}"><img src="{$oUser->getProfileAvatarPath(48)}" alt="avatar" class="avatar" /></a>
			<strong>{$aLang.about_author} {$oUser->getProfileName()}</strong><br />
			{$oUser->getProfileAbout()}<br />
			<a href="{router page='my'}{$oUser->getLogin()}/">{$aLang.topic_author_topics} &rarr;</a>
		</div>
	{/if}
	
	

	<div class="info">
		{$aLang.topic_pub_in} <a href="{$oBlog->getUrlFull()}" class="title-blog">{$oBlog->getTitle()|escape:'html'}</a>
		
		| {$aLang.topic_tags}: 
		{foreach from=$oTopic->getTagsArray() item=sTag name=tags_list}
			<a href="{router page='tag'}{$sTag|escape:'html'}/">{$sTag|escape:'html'}</a>{if !$smarty.foreach.tags_list.last}, {/if}
		{/foreach}	
		
		{if !$tSingle}
			| <span class="comments-link">
				<a href="{$oTopic->getUrl()}#comments" title="{$aLang.topic_comment_read}">{$aLang.topic_comments}: 
				{if $oTopic->getCountComment()>0}
					{$oTopic->getCountComment()} <span>{if $oTopic->getCountCommentNew()}+{$oTopic->getCountCommentNew()}{/if}</span>
				{else}0{/if}</a></span>
		{/if}

		{if $oTopic->getType()=='link'}
			&nbsp;<a href="{router page='link'}go/{$oTopic->getId()}/" title="{$aLang.topic_link_count_jump} {$oTopic->getLinkCountJump()}" class="link">{$oTopic->getLinkUrl(true)}</a>
		{/if}							
		
		{hook run='topic_show_info' topic=$oTopic}
	</div>
</div>
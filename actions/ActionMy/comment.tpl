{include file='header.tpl' menu="profile"}


<h4>{$aLang.author_comments}: <span>{if $oUserProfile->getProfileName()}{$oUserProfile->getProfileName()} ({$oUserProfile->getLogin()}) {else} {$oUserProfile->getLogin()} {/if}</span></h4>

<div class="author-info">
	<a href="{$oUserProfile->getUserWebPath()}"><img src="{$oUserProfile->getProfileAvatarPath(48)}" alt="avatar" class="avatar" /></a>
	{if $oUserProfile->getProfileName()}<strong>{$aLang.about_author} {$oUserProfile->getProfileName()}</strong><br />{/if}
	<strong>{$aLang.author_nickname}:</strong> {$oUserProfile->getLogin()}<br />
	{$oUserProfile->getProfileAbout()}<br />
</div>


{include file='comment_list.tpl'}
{include file='footer.tpl'}
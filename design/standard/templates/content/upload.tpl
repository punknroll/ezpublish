{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<form enctype="multipart/form-data" action={'content/upload'|ezurl} method="post">

{section show=$upload.description_template}
    {include name=Description uri=$upload.description_template upload=$upload}
{section-else}
    <div class="maincontentheader">
    <h1>{"Upload file"|i18n("design/standard/content/view")}</h1>
    </div>

    <p>{'Choose a file from your locale machine and click the "Upload" button. An object will be created according to file type and placed in your chosen location.'|i18n("design/standard/content/view")}</p>
{/section}

{section show=$errors|count|gt( 0 )}
    <div class="error">
        <h2>{"Some errors occured"|i18n( "design/standard/upload" )}</h2>
        <ul>
            {section var=error loop=$errors}
                <li>{$error.description}</li>
            {/section}
        </ul>
    </div>
{/section}

<input type="hidden" name="UploadActionName" value="{$upload.action_name}" />

<div class="createblock">
    <label>{'Location'|i18n( 'design/standard/upload' )}</label>
    <select	name="UploadLocationChoice" class="combobox locationchoice">
        <option value="auto">{'Automatic'|i18n( 'design/standard/upload' )}</option>
    {let root_node_value=ezini( 'LocationSettings', 'RootNode', 'upload.ini' )
         root_node=cond( $root_node_value|is_numeric, fetch( content, node, hash( node_id, $root_node_value ) ),
                         fetch( content, node, hash( node_path, $root_node_value ) ) )}
    {section var=node loop=fetch( content, tree,
                                  hash( parent_node_id, $root_node.node_id,
                                        class_filter_type, include,
                                        class_filter_array, ezini( 'LocationSettings', 'ClassList', 'upload.ini' ),
                                        depth, ezini( 'LocationSettings', 'MaxDepth', 'upload.ini' ),
                                        limit, ezini( 'LocationSettings', 'MaxItems', 'upload.ini' ) ) )}
        <option value="{$node.node_id}">{'&nbsp;'|repeat( sub( $node.depth, $root_node.depth, 1 ) )}{$node.name|wash}</option>
    {/section}
    {/let}
  	</select>

</div>

<div class="createblock">
    <input type="hidden" name="MAX_FILE_SIZE" value="50000000" />
    <input name="UploadFile" type="file" />
    &nbsp;

    <input class="defaultbutton" type="submit" name="UploadFileButton" value="{'Upload'|i18n( 'design/standard/upload' )}" title="{'Click here to upload a file. The file will be placed within the location that is specified using the dropdown menu on the top.'|i18n( 'design/standard/upload' )}" />

 </div>


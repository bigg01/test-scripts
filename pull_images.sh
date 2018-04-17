#/bin/bash
image_version=`curl -s $REPO_URL | grep -oE 'atomic-openshift-3.[0-9]{2}.[0-9]{1,3}[,-][0-9]{1,3}.[0-9]{1,3}.[0-9]' | cut -d- -f3- | uniq`
image_tag=v${image_version}.0

old_image_version=`cat /tmp/image_version`

if [[ $image_version != $old_image_version ]]
then 
    ssh bmeng@fedorabmeng.usersys.redhat.com "sync_images $image_tag"
    if [ $? -eq 0 ]
        then
        touch /tmp/image_version
    	echo -e $image_version > /tmp/image_version
    fi
fi

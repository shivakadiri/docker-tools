rootdir=/tmp/a_my_src

#FIX file and data issues
#convert to utf-8
files_dir=$rootdir/db/adventure-works
mod_files_dir=$files_dir/modified
mkdir $mod_files_dir

sed -i "s/:setvar/--:setvar/g" $mod_files_dir/instawdb.sql #make sure file isnt UTF-16, works only on UTF-8 files
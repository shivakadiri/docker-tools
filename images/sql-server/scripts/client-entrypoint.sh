#! /bin/bash
echo "************* BEGIN: Executing client-entrypoint.sh *************"

rootdir=/tmp/a_my_src

#FIX file and data issues
#convert to utf-8
files_dir=$rootdir/db/adventure-works
mod_files_dir=$files_dir/modified
mkdir $mod_files_dir
#FIX file and data issues
for file in $files_dir/*; do
    if [ -f "$file" ]; then        
        mime_encoding=$(file -b --mime-encoding $file)
        base_file_name=$(basename $file)
        new_file_name=$mod_files_dir/$base_file_name
        echo "Converting: file: $base_file_name mime-encoding: $mime_encoding"
        #iconv -f $mime_encoding -t utf-8 -o $rootdir/db/adventure-works/modified/$(basename $file) $file        
        #convert and copy back to original file, if not, iconv will output file contents to console if -o is not set
        iconv -f $mime_encoding -t ascii $file -o $new_file_name -sc # -sc ignore illegal chars, the input files in this project can be ignored, verified manually
    fi
done

#convert newline and other chars to unix format
dos2unix $mod_files_dir/*.* -q

#replace anything not working
# 1. Comment out :setvar to run it from sqlcmd
sed -i "s/:setvar/--:setvar/g" $mod_files_dir/instawdb.sql #make sure file isnt UTF-16, works only on UTF-8 files
# 2. CODEPAGE is not supported in sql server in linux, so remove for making it work in dev
sed -i "s|CODEPAGE='ACP',||g" $mod_files_dir/instawdb.sql #make sure file isnt UTF-16, works only on UTF-8 files

/opt/mssql-tools18/bin/sqlcmd -No -S db-server -U sa -i $mod_files_dir/instawdb.sql \
    -v DatabaseName=$DB_DATABASE_NAME \
    -v SqlSamplesSourceDataPath=/tmp/a_my_src/data/modified/ \
    -P ${MSSQL_SA_PASSWORD}

/opt/mssql-tools18/bin/sqlcmd -No -S db-server -U sa -i /tmp/a_my_src/db/db-create.sql \
    -v DB_NAME=$DB_DATABASE_NAME \
    -v DB_USER_NAME=$DB_USER_NAME \
    -v DB_USER_PWD=$DB_USER_PASSWORD \
    -P ${MSSQL_SA_PASSWORD}

echo "************* END: Executing client-entrypoint.sh ***************"

sleep infinity

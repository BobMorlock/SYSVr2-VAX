
#	@(#)uudemon.day.sh	1.4

# 'perform once per day at 0400 hours'
PATH=:/usr/lib/uucp:/bin:/usr/bin
cd /usr/lib/uucp
uuclean -p -m -n168 >/dev/null 2>/dev/null
uuclean -d.XQTDIR -p -n72 >/dev/null 2>/dev/null
uustat -c168 >/dev/null 2>/dev/null
cd /usr/spool/uucp
mv LOGFILE temp
uniq -c temp >> Log-WEEK
rm temp
uusub -call -u24
cd /usr/spool/uucppublic
find . -type f -mtime +30 -exec rm -f {} \;

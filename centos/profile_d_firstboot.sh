if [ -f /etc/rc3.d/S11firstboot ]
then
echo "*********************************************"
echo "WARNING.. not puppetized yet!"
echo ""
echo "try running /etc/rc3.d/S11firstboot"
echo ""
echo " I bet $HOSTNAME doesn't resolve"
echo ""
echo " either way S11firstboot didn't finish running"
echo "*********************************************"
fi

import os, subprocess

subprocess.call('adb pull /system/build.prop', shell=True)

buildprop = open('build.prop','r');
links = open('Links.txt','w');

for eachline in buildprop:
	if 'ro.cm.device' in eachline:
		_devicecodename = str(eachline[13:]).rstrip('\n')
	elif 'ro.cm.version' in eachline:
		_version = str(eachline[14:]).rstrip('\n')
	elif 'ro.build.version.incremental' in eachline:
		_build = str(eachline[29:]).rstrip('\n')

buildprop.close()		
os.remove('build.prop')
		
links.write('http://builds.cyngn.com/cyanogen-os/' + _devicecodename + '/' + _version + '/' + _build + '/cm-' + _version + '-signed-fastboot.zip' + '\n')
links.write('http://builds.cyngn.com/cyanogen-os/' + _devicecodename + '/' + _version + '/' + _build + '/cm-' + _version + '-signed-fastboot.zip.md5sum' + '\n\n')
links.write('http://builds.cyngn.com/cyanogen-os/' + _devicecodename + '/' + _version + '/' + _build + '/cm-' + _version + '-fastboot.zip' + '\n')
links.write('http://builds.cyngn.com/cyanogen-os/' + _devicecodename + '/' + _version + '/' + _build + '/cm-' + _version + '-fastboot.zip.md5sum' + '\n\n')
links.write('http://builds.cyngn.com/cyanogen-os/' + _devicecodename + '/' + _version + '/' + _build + '/cm-' + _version + '-signed.zip' + '\n')
links.write('http://builds.cyngn.com/cyanogen-os/' + _devicecodename + '/' + _version + '/' + _build + '/cm-' + _version + '-signed.zip.md5sum' + '\n\n')
links.write('http://builds.cyngn.com/cyanogen-os/' + _devicecodename + '/' + _version + '/' + _build + '/cm-' + _version + '-boot-debuggable.img' + '\n')
links.write('http://builds.cyngn.com/cyanogen-os/' + _devicecodename + '/' + _version + '/' + _build + '/cm-' + _version + '-boot-debuggable.img.md5sum')
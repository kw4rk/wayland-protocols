project('wayland-protocols',
	version: '1.31',
	meson_version: '>= 0.58.0',
	license: 'MIT/Expat',
)

wayland_protocols_version = meson.project_version()

fs = import('fs')

stable_protocols = [
	'presentation-time',
	'viewporter',
	'xdg-shell',
]

unstable_protocols = {
	'fullscreen-shell': ['v1'],
	'idle-inhibit': ['v1'],
	'input-method': ['v1'],
	'input-timestamps': ['v1'],
	'keyboard-shortcuts-inhibit': ['v1'],
	'linux-dmabuf': ['v1'],
	'linux-explicit-synchronization': ['v1'],
	'pointer-constraints': ['v1'],
	'pointer-gestures': ['v1'],
	'primary-selection': ['v1'],
	'relative-pointer': ['v1'],
	'tablet': ['v1', 'v2'],
	'text-input': ['v1', 'v3'],
	'xdg-decoration': ['v1'],
	'xdg-foreign': ['v1', 'v2'],
	'xdg-output': ['v1'],
	'xdg-shell': ['v5', 'v6'],
	'xwayland-keyboard-grab': ['v1'],
}

staging_protocols = {
	'content-type': ['v1'],
	'drm-lease': ['v1'],
	'ext-idle-notify': ['v1'],
	'ext-session-lock': ['v1'],
	'fractional-scale': ['v1'],
	'single-pixel-buffer': ['v1'],
	'tearing-control': ['v1'],
	'xdg-activation': ['v1'],
	'xwayland-shell': ['v1'],
}

protocol_files = []

foreach name : stable_protocols
	protocol_files += ['stable/@0@/@0@.xml'.format(name)]
endforeach

foreach name : staging_protocols.keys()
	foreach version : staging_protocols.get(name)
		protocol_files += [
			'staging/@0@/@0@-@1@.xml'.format(name, version)
		]
	endforeach
endforeach

foreach name : unstable_protocols.keys()
	foreach version : unstable_protocols.get(name)
		protocol_files += [
			'unstable/@0@/@0@-unstable-@1@.xml'.format(name, version)
		]
	endforeach
endforeach

# Check that each protocol has a README
foreach protocol_file : protocol_files
	dir = fs.parent(protocol_file)
	if not fs.is_file(dir + '/README')
		error('Missing README in @0@'.format(protocol_file))
	endif
endforeach

foreach protocol_file : protocol_files
	protocol_install_dir = fs.parent(join_paths(
		get_option('datadir'),
		'wayland-protocols',
		protocol_file,
	))
	install_data(
		protocol_file,
		install_dir: protocol_install_dir,
	)
endforeach

pkgconfig = import('pkgconfig')

pkgconfig.generate(
	name: 'Wayland Protocols',
	description: 'Wayland protocol files',
	dataonly: true,
	variables: {
		'prefix': get_option('prefix'),
		'datarootdir': '${prefix}/@0@'.format(get_option('datadir')),
		'pkgdatadir': '${pc_sysrootdir}${datarootdir}/wayland-protocols'
	},
	uninstalled_variables: {
		'pkgdatadir': meson.project_source_root(),
	},
)

wayland_protocols = declare_dependency(
	variables: {
		'pkgdatadir': meson.project_source_root(),
	},
)

meson.override_dependency('wayland-protocols', wayland_protocols)

if get_option('tests')
	subdir('tests')
endif

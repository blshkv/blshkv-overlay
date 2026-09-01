# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="johnfanv2/LenovoLegionLinux"
GITHUB_TAG="v${PV}"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{12..14})
inherit github-archive linux-mod-r1 distutils-r1 systemd optfeature

MODULES_KERNEL_MIN=5.10

DESCRIPTION="Lenovo Legion Linux kernel module"

LICENSE="GPL-2"
SLOT="0"
IUSE="+gui downgrade-nvidia elogind"

BDEPEND="
	sys-kernel/linux-headers
	sys-apps/lm-sensors
	sys-apps/dmidecode
	sys-apps/sed
	dev-libs/inih
"

RDEPEND="
	gui? (
		dev-python/pyqt6[gui,widgets]
		dev-python/pyyaml
		dev-python/argcomplete
		dev-python/darkdetect
		sys-power/acpid
	)
	downgrade-nvidia? ( <=x11-drivers/nvidia-drivers-525-r0 )
"

DEPEND="${RDEPEND}"

src_compile() {
	local modlist=(
		legion-laptop=kernel/drivers/platform/x86:kernel_module:kernel_module:all
	)
	export KERNELVERSION=${KV_FULL}
	linux-mod-r1_src_compile
	if use gui; then
		#fix python package version
		sed -i "s/version = _VERSION/version = ${PV}/g" "python/legion_linux/setup.cfg"
		#Define build dir (fix sandboxed)
		cd "python/legion_linux" || die
		distutils-r1_src_compile --build-dir "python/legion_linux/build"
		cd "legion_linux/extra/service/legiond" || die
		emake
	fi
}

src_install() {
	linux-mod-r1_src_install
	if use gui; then
		#Define build dir (fix sandboxed)
		cd python/legion_linux/ || die
		distutils-r1_src_install --build-dir build

		cd ../..
		cd extra || die

		systemd_dounit service/{legiond.service,legiond-onresume.service,legiond-cpuset.service,legiond-cpuset.timer}

		newinitd service/legiond.initd legiond
		newinitd service/legiond-cpuset.initd legiond
		newsbin service/legiond-cpuset.sh legiond-cpuset

		if use elogind; then
			exeinto /lib64/elogind/system-sleep/
			doexe service/legiond-onresume.sh
		fi

		insinto /etc/acpi/events
		doins acpi/events/{legion_ppd,legion_ac}
		dobin service/legiond/legiond
		dobin service/legiond/legiond-ctl
	fi
}

pkg_postinst() {
	ewarn "Default config files are present in /usr/share/legion_linux"
	ewarn "Copy folder /usr/share/legion_linux to /etc/legion_linux"
	ewarn "Note: Fancurve can be edit using the gui app"
	ewarn "Dont forget to edit /etc/legion_linux/legiond.ini (previous .env) to enable and disable extra features"
	ewarn "Note the CPU and APU control command both for undervolt an ryzenadj are edit in /etc/legion_linux/.env"
	if !use downgrade-nvidia; then
		ewarn "Note: use flag downgrade-nvidia if you need for nvidia TDP control (requires driver 525 to work)\n"
		ewarn "This useflag will be drop soon since 525 is almost 6 months old"
	else
		ewarn "Note: Edit /etc/legion_linux/.env to enable nvidia TDP control\n"
	fi
	ewarn "Note for 2023-2023 Legion user: It need help for testing the features"
	ewarn "Pls test the feature how is decribe in the README of the project!"
	ewarn "and also go to this issue in github: https://github.com/johnfanv2/LenovoLegionLinux/issues/46"

	optfeature "radeon dgpu power management" dev-util/rocm-smi
	optfeature "ryzen CPU tweaks" sys-power/RyzenAdj
	optfeature "intel CPU tweaks" sys-power/intel-undervolt
}

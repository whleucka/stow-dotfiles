use std::process::{Command,Stdio};
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    let package_name = args.get(1).expect("You must provide a package name");
    let output = Command::new("yay")
        .arg("-Ss")
        .arg(package_name)
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute yay process")
        .stdout
        .unwrap();

    let output = Command::new("sed")
        .arg("N;s/\\n/=>/")
        .stdin(Stdio::from(output))
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute sed process")
        .stdout
        .unwrap();

    let output = Command::new("tr")
        .args(&["-s", " "])
        .stdin(Stdio::from(output))
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute tr process")
        .stdout
        .unwrap();

    let output = Command::new("sort")
        .stdin(Stdio::from(output))
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute sort process")
        .stdout
        .unwrap();

    let output = Command::new("fzf-tmux")
        .args(&["--header", "Select a package to install..."])
        .stdin(Stdio::from(output))
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute fzf-tmux process")
        .stdout
        .unwrap();


    let package_name = Command::new("cut")
        .args(&["-d", " ", "-f1"])
        .stdin(Stdio::from(output))
        .output()
        .expect("Failed to execute cut process");

    let install_package = String::from_utf8_lossy(&package_name.stdout);
    println!("Now installing install {}\n", install_package);

    let _ = Command::new("yay")
        .arg("-S")
        .arg(install_package.as_ref().trim())
        .spawn()
        .expect("Failed to install package")
        .wait();
}

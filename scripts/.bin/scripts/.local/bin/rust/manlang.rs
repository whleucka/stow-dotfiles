use std::io;
use std::process::{Command, Stdio};

fn main() {
    let output = Command::new("echo")
        .arg("php rust typescript nodejs cpp python bash lua")
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute echo process")
        .stdout
        .unwrap();

    let output = Command::new("tr")
        .args(&[" ", "\\n"])
        .stdin(Stdio::from(output))
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute tr")
        .stdout
        .unwrap();

    let output = Command::new("fzf-tmux")
        .stdin(Stdio::from(output))
        .stdout(Stdio::piped())
        .spawn()
        .expect("Failed to execute fzf process")
        .stdout
        .unwrap();

    let name = Command::new("cut")
        .args(&["-d", " ", "-f1"])
        .stdin(Stdio::from(output))
        .output()
        .expect("Failed to execute cut process");

    let lang = String::from_utf8_lossy(&name.stdout);

    println!("QUERY: ");
    let mut query = String::new();
    io::stdin()
        .read_line(&mut query)
        .expect("Failed to read command");
    let url = format!("https://cht.sh/{}/{}", lang.trim(), query);

    let output = Command::new("curl")
        .arg("-s")
        .arg(url.trim())
        .output()
        .expect("Failed to execute curl");
    let stdout = String::from_utf8_lossy(&output.stdout);
    println!("{}", stdout);

}

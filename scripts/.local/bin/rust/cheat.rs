use std::io;
use std::process::Command;

fn main() {
    println!("COMMAND: ");
    let mut command = String::new();
    io::stdin()
        .read_line(&mut command)
        .expect("Failed to read command");
    let url = format!("https://cheat.sh/{}", command);
    let output = Command::new("curl")
        .arg("-s")
        .arg(url.trim())
        .output()
        .expect("Failed to execute curl");
    let stdout = String::from_utf8_lossy(&output.stdout);
    println!("{}", stdout);
}

use std::env;
use std::process::Command;

fn main() {
    let args: Vec<String> = env::args().collect();
    let host = args.get(1).expect("You must provide a host");
    let fingerprint = args.get(2).expect("You must provide a fingerprint");
    let session_id = args.get(3).expect("You must provide a session ID");
    let pattern = format!("/Started tx: {}/,/Started tx/p", session_id);
    let command = format!(
        "'sed -n \"{}\" /var/log/supervisor/lamassu-machine.err.log'",
        pattern
    );
    let output = Command::new("ssh")
        .arg(host)
        .arg("-C")
        .arg("pssh")
        .arg(fingerprint)
        .arg(command)
        .output()
        .expect("Failed to execute ssh process");
    let session = String::from_utf8_lossy(&output.stdout);
    println!("{}", session)
}

Certainly! Below is a comprehensive README file for your GitHub repository, providing detailed instructions, usage examples, and contribution guidelines for your DNS server testing and optimization project.

---

# DNSPerfTest

![DNSPerfTest Logo](https://via.placeholder.com/150) <!-- Replace with your project logo if available -->

**DNSPerfTest** is a powerful Bash script designed to help you evaluate and optimize DNS server performance. This script tests a comprehensive list of public DNS servers for latency, jitter, and packet loss, providing you with detailed insights into their performance. With DNSPerfTest, you can:

- **Automate DNS Server Testing**: Test multiple DNS servers with a single command, making it easy to compare their performance.
- **Identify Best Performing Servers**: The script ranks DNS servers based on their latency and packet loss, helping you identify the top performers.
- **Visualize Results**: Results are presented in a clear, tabular format, with the best performers highlighted in green and servers with packet loss marked in red.
- **Optimize Network Configuration**: Optionally, the script can automatically set the top 5 DNS servers with the best ping times as your system's nameservers in `/etc/resolv.conf`.

## Features

- **Comprehensive Testing**: Tests a wide range of public DNS servers, including Google DNS, Cloudflare, OpenDNS, and more.
- **Real-Time Results**: Get immediate feedback on each DNS server's performance as the tests are conducted.
- **Customizable**: Easily modify the list of DNS servers and the number of ping requests to suit your needs.
- **User-Friendly**: Simple command-line interface makes it accessible for users of all skill levels.

## Getting Started

### Prerequisites

- **Bash**: Ensure you have Bash installed on your system.
- **Ping**: The script uses the `ping` command to test DNS servers.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/DNSPerfTest.git
   cd DNSPerfTest
   ```

2. Make the script executable:
   ```bash
   chmod +x test_dns.sh
   ```

### Usage

1. Run the script:
   ```bash
   ./test_dns.sh
   ```

2. Follow the on-screen prompts to set the top 5 DNS servers as your system's nameservers if desired.

### Example Output

```
Sorted Results:
DNS Server      Packet Loss     Average Latency (ms)
8.8.8.8         0%              10 ms
1.1.1.1         0%              12 ms
9.9.9.9         1%              15 ms
208.67.222.222  2%              18 ms
```

## Contributing

Contributions are welcome! Here’s how you can help:

1. **Fork the Repository**: Click the "Fork" button on the top right of this page.
2. **Clone Your Fork**: `git clone https://github.com/yourusername/DNSPerfTest.git`
3. **Create a New Branch**: `git checkout -b new-feature`
4. **Make Your Changes**: Implement your changes or add new features.
5. **Commit Your Changes**: `git commit -m "Add new feature"`
6. **Push to Your Fork**: `git push origin new-feature`
7. **Submit a Pull Request**: Go to the original repository and click the "New Pull Request" button.

Please ensure your pull request adheres to the following guidelines:
- Code should be well-documented.
- Changes should be tested before submission.
- Follow the existing code style and conventions.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or feedback, feel free to open an issue or contact the maintainers directly.

---

With DNSPerfTest, you can ensure that your network is configured with the best performing DNS servers, enhancing your internet experience and application performance.

---

Feel free to customize the README further to better match your project's specifics or add any additional details you think are relevant.

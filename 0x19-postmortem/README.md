https://docs.google.com/document/d/1nVb2GFL8uRnRCzRtOPzmJhDHPNR70ebKBs8gbEZ9jME/edit?usp=sharing


Postmortem Report: Outage on Photo Upload Service of Social Media Platform X

Issue Summary
Duration of Outage:
Start: August 16, 2024, 14:30 UTC
End: August 16, 2024, 16:00 UTC
Impact:
The outage affected the photo upload feature on Social Media Platform X, causing slow or failed uploads for 45% of users. Users experienced long delays or outright failures when attempting to upload images, resulting in frustration and a significant decrease in platform engagement during the outage.
Root Cause:
The root cause of the outage was a memory leak in the image processing service due to a recent update that inadvertently introduced inefficient memory management. This led to the service crashing under load.

Timeline
14:30 UTC - Issue detected via monitoring alert indicating a spike in upload failures.
14:35 UTC - Initial investigation by the on-call engineer; confirmed high failure rate for image uploads.
14:45 UTC - Misleading path: Initial assumption was that the issue was due to network latency, leading to a network diagnostic check.
15:00 UTC - Network diagnostics showed no significant issues. Incident escalated to the backend engineering team.
15:10 UTC - Backend team identified that the image processing service was consuming excessive memory.
15:20 UTC - Further investigation revealed a memory leak in the image processing service.
15:30 UTC - Misleading path: Attempted to resolve the issue by restarting the service, but the problem recurred within minutes.
15:45 UTC - Root cause confirmed: a bug in the recent update to the image processing service.
15:50 UTC - A hotfix was developed and deployed to resolve the memory leak.
16:00 UTC - Service restored; uploads functioning normally.

Root Cause and Resolution
Root Cause:
The issue stemmed from a recent update to the image processing service, which introduced a memory leak. The service was designed to handle high volumes of image uploads, but the inefficient memory management caused it to consume excessive memory, leading to crashes when the system ran out of available memory. The crashes resulted in the failure of image uploads for a significant portion of users.
Resolution:
The resolution involved identifying the specific portion of the code that was causing the memory leak. The engineering team quickly developed a hotfix that corrected the memory allocation process, ensuring that memory was properly freed after processing each image. This hotfix was tested in a staging environment before being deployed to production. Once deployed, the service returned to normal operation, and image uploads were restored.

Corrective and Preventative Measures
Improvements:
Improved testing procedures to catch memory leaks and other performance issues before updates are deployed.
Enhanced monitoring of the image processing service to detect abnormal memory usage earlier.
Increased redundancy in the image processing service to mitigate the impact of similar issues in the future.
TODO List:
Patch image processing service: Update the image processing service with the hotfix to prevent memory leaks.
Implement memory usage monitoring: Add detailed memory usage monitoring and alerting for the image processing service.
Improve testing: Enhance the testing suite to include stress tests that simulate high memory usage scenarios.
Update rollback procedures: Review and update rollback procedures to ensure a faster response if a similar issue arises in the future.
Conduct a post-incident review: Hold a post-incident review meeting with all involved teams to discuss lessons learned and further preventative measures.


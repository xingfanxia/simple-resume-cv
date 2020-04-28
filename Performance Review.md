# Performance Review

## Self Review

### (Onboarding) Realtime Risk Singal

Fengshui Exploration

### SOA

Coupon Defense SOA

### coupon fraud defense

Add Exemption to defense, as well as monitoring/metrics in ruby codebase

### Fengshui Data Duplication

### Technical Project Details #1 - Delayed Payout for China New Hosts

#### Project abstract

- **The Problem**

  The exisitng payout scheme pays most hosts 24 hours after guests' check-in date. This makes it a very easy loophole for fraudsters to exloit and gets payout as early as 8 hours after their reservation is accepted. This leaves us very little time to react to it and prevent fraudsters from cashing out. 

  After researching our competitors in China regarding their payout policy, they have all adopted a much more fraud-proof scheme so we become a easy target to fraudsters. Thus , we decided to adopt delayed payout for China new hosts to create more friction for fraudsters on our platform and enable us more time to react to them.

- **The Challenges**

  The design of delayed payout is not a easy task and has undergone a lot of changes and evolution. Initially, Sikai and I were planning to write a whole new Java service for it called `Chibi` . However, after numerous meetings with different teams, we have settled to a design that satisfies various interest partis' needs, which is to develop delayed payout on top of existing tools and frameworks like `Roc` , `Monama` , `Kyoo` , etc. 

- **Impact**

  We successfully launched the pilot experiment in 4 cities in China which is the foundation for the future full China launch which could lead to a potential **$10M** anual saving in fraudulent payout loss. Delayed Payout will not only lead to direct financil savings but also strengthen our general fraud defense by giving us more time to react.

#### Involvement

- I have taken on the responsibility to finish the Kyoo rule engine implmentation part of delayed payout. Specifically I have implemented various data sources, signals, rules, and policy for delayed payout. Some of the data sources interfaces are not readily available in Kyoo and I have built them for it.
- Attended meetings to discuss the design of the project.
- My primary collaborators on this project is Sikai Zhu and Carl You. I want to give special thanks to Carl for ramping me up with the Kyoo rule engine and carefully reviewing my PRs. And special thanks to Sikai Zhu for giving me guidance thrughout the project, especially on communicating with PoCs from different teams and user communication related work.
- The primary stakeholders are global trust team, global payment team, storage team, China CX team, China growth team. The main organizational challegnges we face earlier is that teams does not agree with each other on the implementation of this project. And after we finalized the project implementation design, it was also a challenge to work with teams based in Beijing office who has a 15 hrs time difference with us.
- We have successfully delivered the pilot launch timely to collect more data and awaiting some leadership decisions regarding policy changes and legal approval to continue to future stages. And it is in milestone 1 we defined, and we plan to lay out milestone 2 and 3 in the next half including the full launch, host profiling scoring system, tierd payout schedule, etc.

#### Docs

- <https://docs.google.com/presentation/d/1ckWrAs_PmImuU4AzlQ7kSj2FdNDUPGWCAeIWRUIwiPU/edit#slide=id.g56e8abc2e8_0_0>
- <https://docs.google.com/presentation/d/1SVbJIplJCaCyxXgOeN96z-IzFTiLSU13x1x4HAjORoc/edit#slide=id.g28ca738862_1_0>
- <https://docs.google.com/document/d/1i-mKX2RIQGX8tB2kqI3DH7iT89PeceonXWsRQgX1KbI/edit>
- <https://docs.google.com/document/d/18LyjXWlnuk_FrguIc8t3fV7TUKn_aw_Y1WiZHa1K0BA/edit>
- <https://docs.google.com/document/d/1JS_VfrvJpX19dQsmDm3XFy6fX3BxToO5ACH_d0322x8/edit>
- <https://docs.google.com/document/d/15V9i6MC8r3Q9qBBLqk9Gk4V2qB8cGZ_3kEVWd6mZFVc/edit>

### **Technical Project Details #2** - Fake Review/Reservation

#### Project Abstrat

- **The Problem**

  - Fake review is a big ongoing project that is not limited to the scope its name suggests. Instead it is a critical component of the host side risk prevention. It involves coupon abuse, referral credit abuse, fake inventory. The negative impact of fake review not only includes direct financial loss from referral credit, but also reduces the coupon efficiency of our growth budget. In addition, it undermines the trust on our platform which is a critical part of Airbnb's mission.

  - The current status of fake review impacts **1.9%** of our domestic nights, **3.4%** of our domestic reservations, **10%** of coupon efficiency degradation, **14.8%** domestic financial loss in China

- **The Challenges**

  - The scope of fake review is so big that it is quite difficult to decide how to get started
  - Fraudsters have many different means to complete fake reviews, with or without coupon, making or not makintg financial loss to us and they often do these in a mix to create confusion.

- **Impact**

  At the time of the project, I have succesfully launched the initial defense which adds **8000** bad referrers to our blacklist which is **twice** the size of our original blacklist. And results in **$1.4M** saving in referral credit.

#### Involvement

- The primary collaborators are Sikai Zhu and Shanshan Chen.

- Worked with Sikai and Shanshan to come up with plans and milestones for the project.
- Worked with Sikai and Shanshan to come up with design for a topological approach to tackle down the referrer side. Implemented the data pipeline to find these risky referrers and add them to black list to block their credit usage.
- Did research in risky fake reservations and applied different clustering algorithm as well as using random forest classifier to find important features and common characterisitics of them to serve to reservation level fake reservation detection.
- We are currently at the milestone 1 of this project and I will continue to drive the effort of milestone 2 and milestone 3.

#### Docs

- <https://docs.google.com/presentation/d/1A0VfATSCcw75gXUWmlLc0pjYCknu8AoAAxVkdkRQX1E/edit#slide=id.g58cbb6f0df_0_139>
- <https://docs.google.com/presentation/d/1l0g6uCEBpvbVpanWjrcXvaD0VIyifGeMF0ZJrJsetqo/edit#slide=id.g5df91dd0e0_0_299>
- <https://airbnb.quip.com/gk3pAxX6rbwy/Attributes-for-fake-reso-and-referral-fraud>

### **Technical Project Details #3** - Icarus Alert Framework

#### Project Abstrat

- **The Problem**

  - This project originates to solve a problem we are having here at china risk team. We have many dashboards and charts to monitor yet there is no automatic alerting system. Because most of these charts depends on hive table generated with Airflow DAGs, and there is no existing method to really get alerts from superset responding to a spike in graphs or some metrics going over threshold. In one sentence, we want query-based alerting. Like Chisel but run alerts instead.

  - There is already a workflow to achieve the outcome of this project already, but that requires a lot of effort including writing two PRs setting up dags, datadog monitors and linking them together.

- **The Challenges**

  The Challenging part of this project is that it needs to simplify an exiting workflow into a very simple config file. So David and I have to stitch all these components up seemlessly and introduce a  simple yet full-functional config design.

- **The Impact**

  - This project will enable the china risk team with faster response to potential fraud trend happening on our platform so we can act more quickly to reduce the damage, saving us $$$
  - This project will also be introduced to the other teams in Airbnb, empowering their work as well.

#### Involvement

- The primary collaborator is David Rincon-Cruz.
- I did the overall architecture design and worked with David to make it more complete and resilient.
- Managed team meetings to discuss the project design and progress.
- I implemented the MVP project stitching all the necessary components into a functional product. David did the refactoring and optimization of the MVP into a milestone 1 product.
- This is currently at milestone 1 which is completely functional, we are planning to add more features and a UI to it in milestone 2.
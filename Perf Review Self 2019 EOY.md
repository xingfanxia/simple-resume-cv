## Perf Review Self

### Technical Project Details #1 - Incentive Fake Review

#### Project Abstract

- **The Problem**

  Incentive fake review refers to a type of reservation when the guest doesn't book a real reservation instead of collude with host to give hosts fake reviews (often plus cash reward) in exchange of the opportunity to cash out referral credits (sometimes also referral coupons). 

  Incentive Fake Review has been a long existing problem in China market and has been growing rapidly mid year 2019, and the volume of fake reservations peaked at 6% of all China bookings. We have taken actions in three phases to defend this trend.

- **The Challenges**

  The challenge of fake reviews lies in

  - The maganitude and prevalence of it is really large.
  - How similiar it may seems to a regular legitimate reservation,  making it extra difficult to take actions towards fake reviews becasue we don't want to harm the good users.
  - It appears in many different forms utilizing different strategies, making it difficult to generalize them.

- **Impact**

  - Launched defense in 3 stages and successfully brought down the volume of incentive fake reviews in China market from **6% (at peak)** to lower than **0.1%**. Not only saved over **2M** in referral credits and coupons but also improve the trust on our platform significantly.

#### Phase One - Detection and Defense on High Risk Referrer

- Worked with Sikai and Shanshan, built dags that employs topological method to capture bad referrers and made offline tables & dashboard to keep track of them. launched initial defense to block high risk reservations and ghost bad referrers and guests.
- **Impact**
  - Caputured and ghosted **30,000** high risk referrers (at an estimated precision of 99.5%) and saved over **2M** USD in referral credits.

#### Phase Two - Reservation Level Kyoo Rule Defense

- Worked with Sikai and Shanshan, Studied the common characteristics of the most common type of fake reviews by analyzing over 2M reservations in their cashflow, guest, and host profiles.
- From the study extracted common features of incentive fake review reservations and built a *Kyoo Rule* on all reservations with incentives to defend incentive fake review on a reservation level.
- **Impact**
  - Captured over **7,000** high risk reservations using the rule on a daily average of **68** high risk reservations.

#### Phase Three - Logistic Regression Machine Learning Model Based Reservation Level Defense and Dedicate Fake Review Queue

- After the effort from phase one and phase two, we successfully brought down the volume of fake reviews in China market to about **2%** of total China booking volume.

- However, because rules are rigid which makes it easy to bypass by experienced fraudsters. Also, there are some smaller but different incentive fake reviews not caught by the rule. So we decided to utilize the power of machine learning to solve this problem further.

- Worked with Shanshan to generate labels for model training. During this time, also migrated the whole fake review project onto Apache Spark, made dag execution 2000 times more efficient. (typically brought a **12-15 hours** dag exeuction time to about **5 minutes**)

- Experiemented with different machine learning algorithms including random forest, SVG, K-means Clustering, etc.. Settled with logistic regression as the base algorithm for incentive fake reviews.

- Trained model with different techniques and different labels, after 32 iterations, the model reached precision of **94.5%** and recall of **99%**.

- Worked with Sikai and Shanshan, drafted documents for the model review commitee. After the committe approved the model, model was released in shadow run in parallel to existing rule based defense.

  During one week of shadow run,  the model is able to reach **90% precision** and expands recall **by 14 times (493 resos to 36 resos)** compared to the rule.

- Worked with Sikai, built a dedicated fake review queue and relased model to production to enqueue high risk reservations into the queue. 
  In the first month, the model is able to capture **1000** fake reservations with an average precision of **88%.**

- Sikai and I closely monitored the enqued reservations and discovered some new fraud trends. To react to those new trends, we tweaked the model threshold and feature weights.
  Enqueued about **3,000** reservations to date and about **40%** of them were confirmed to be fake reservations by agent review.

#### Next Step

Alghough incentive fake reviews has dropped to a insiginificant level, non-incentive fake reviews has been climbing at the same time which would be a priority for 2020 H1.

#### Docs

- [Fake Reservation Deck](https://docs.google.com/presentation/d/1qmpdCP_v6KtDuBaSEmuqUiabsDAgLUT93QqCb5DUpTw/edit#slide=id.g1d7dafd5b1_4_4)
- [Fake Review Doc Folder](https://airbnb.quip.com/folder/fake-reviews)
- [Fake Review LR Model Doc List](https://airbnb.quip.com/QFXuAMKuceUW/Fake-Reso-LR-Model-Doc-List)
- [LR Model One Pager](https://airbnb.quip.com/atdpAaNIT8bX/One-Pager-LR-model-for-China-Fake-Reservation)
- [LR Model V2 Technical Summary](https://airbnb.quip.com/1rqeA8kUYAqP/Fake-Reservation-LR-Model-V2-Summary)

#### Appreciation

- Special thanks to Sikai and Shanshan for their help throughtout this project
- Also thanks to Zhui, Weian, and China Trust Defense team to support this project

### Technical Project Details #2 - Chibi (Host Profile Service)

#### Project Abstract 

##### The problem

As a risk team, we often encounterd different teams requesting a risk evaluation for some particular senario. Therefore we made Chibi.

**What is Chibi**

Chibi is a service to determine host profiling score from risk standpoint, similar to user credit score. For example, it can be used to various risk defense rules that involve host side risk, or help determine business decisions in other products, such as delay payout, host affiliation, or quality framework.

#### Chibi for China Delay Payout Policy

- Implement Mussel IDL Client in Chibi and Wrapped as `MusselDataLoader`
- Implemented an endpoint for China Delay Payout Policy to consume upstream signals and produce risk scores
- Implement Chibi Interface in Kyoo to consume chibi risk scores

#### Chibi for Host Affiliate Program

#### Implementation of Chibi Risk Endpoint for Host Affiliate Program

- Implemented Sitar Client in Chibi and Wrapped as `SitarConfigLoader` 
- Implement an endpoint for Host Affiliate Program to determine if a host is eligible
- Work with Ansel Qiao in Host Affiliate Program to make sure Chibi is seamlessly integrated with Heifei Service

#### Impact

- Implemented the first two endpoints in Chibi for both internal and external consumers, serving over at 70 qps and millions of requests
- Established the workflow for future inter-team collabrations for new Chibi Endpoints

#### Docs

- https://git.musta.ch/airbnb/treehouse/tree/master/projects/chinarisk/chibi

#### Appreciations

- Special thanks to Sikai for support along the side
- And to Ansel Qiao and Alexander Kojevnikov for working together to debug a Kubernetes Multicluster Migration Issue

### Smaller Projects

#### Fengshui SOA

- Upgraded the old oyster KV store client to Mussel IDL client and built wrappers to support both rudimentary and complex mussel queries.
- Added Usercashflow to Fengshui.
- Improved Fengshui test coverage by 3%.
- **Impact:** Improved Fengshui stability and adds more realtime signals to User Cashflow. 

#### Icarus Redesign

- Replaced the old configuration storage schema with a more generic and modular design so it is much easier to add new configurable fields which allows more flexible alerts.
- **Impact:** Improved usability and stability of Icaurs, up to this point, half of the team have been utilizing Icarus to keep track of fraud trend, OKR, critical thresholds, etc.

### Others

- Launched ERF for Delay Payout graduation policy.
- Worked with sales team with their Host Ambassador Program to provide risk signals for partnership FTB bookings. Caught 1445 high risk reservations and saved **10,000** USD.
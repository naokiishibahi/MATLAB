clear; close all;

%Parameters
Rl = 10e-2; % 10cm
Rr = 10e-2; % 10cm
B = 20e-2; % 20cm

%Time
dt = 0.01; % sample time
l = 20/dt; % sample number

%Create a matrix
x = zeros(l,3); % location [x, y, theta]
x_dot = zeros(l,3); % velocity [x', y', theta']
ICC = inf(l,2); % instantaneous center of curvature [x, y]

%simulator
for k=2:l
    t = k*dt;
    Wl = 5*sin(3*t);
    Wr = 4*sin(3*t+1);
    Vl = Wl*Rl;
    Vr = Wr*Rr;
    R = B/2*(Vr+Vl)/(Vr-Vl);
    w = (Vr-Vl)/B;
    v = (Vr+Vl)/2;
    ICC(k,:) = [x(k-1,1)-R*sin(x(k-1,3)), x(k-1,2)+R*cos(x(k-1,3))];
    x_dot(k,:) = [v*cos(x(k-1,3)), v*sin(x(k-1,3)), w];
    x(k,:) = x(k-1,:) + x_dot(k,:)*dt;
    h1.XData = x(1:k,1);
    h1.YData = x(1:k,2);
    h2.XData = ICC(1:k,1);
    h2.YData = ICC(1:k,2);
    drawnow limitrate;
end

%plot
figure;
h1 = plot(x(:,1),x(:,2));
hold on;
h2 = plot(ICC(:,1),ICC(:,2));
axis equal;
axis([0 2.5 0 2.5]);
xlabel('X(m)'); ylabel('Y(m)');
legend('trajectory','ICC');
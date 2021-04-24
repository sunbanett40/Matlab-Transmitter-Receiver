clear all

frames_per_second = 25;
samples_per_plot = 200;
seconds_per_plot = 4;
max_amplitude = 3;
max_frequency = 20;
min_frequency = 0.1;

gap = 40;
small_plot_height = 100;
big_plot_height = 2*small_plot_height + gap/2;

samples_per_frame = samples_per_plot/frames_per_second/seconds_per_plot;
seconds_per_frame = 1/frames_per_second;
seconds_per_sample = seconds_per_plot/samples_per_plot;
samples_per_second = 1/seconds_per_sample;
max_frequency = min(max_frequency,samples_per_second*0.499);

fig1 = figure('Units','pixels','Position',[0,0,3*samples_per_plot+10*gap,big_plot_height+2*small_plot_height+6.5*gap],'Resize','off','Name','Addition of Cosines','MenuBar','none');

pause_button = uicontrol('Style','togglebutton','Units','pixels','Position',[0.5*gap,big_plot_height+2*small_plot_height+5.5*gap-12.5,100,25],'String','Pause','Value',0,'FontSize',12,'ToolTip','Pause the simulation');

x_limits = [0, seconds_per_plot];

axes11 = axes;
plot11 = plot(nan,'Parent',axes11);
set(axes11,'Units','pixels','Position',[2*gap,2*small_plot_height+4.5*gap,samples_per_plot,big_plot_height],'YLim',[-max_amplitude*1.1,max_amplitude*1.1],'XLim',x_limits,'Box','on','FontSize',12);
set(get(axes11,'XLabel'),'String','t    [s]','FontSize',12)
set(get(axes11,'YLabel'),'String','x(t)','FontSize',12)
set(get(axes11,'Title'),'String','Time domain','FontSize',12)

axes12 = axes;
plot12 = plot(nan,'Parent',axes12);
set(axes12,'Units','pixels','Position',[2*gap,small_plot_height+2.5*gap,samples_per_plot,small_plot_height],'YLim',[-max_amplitude*0.1,max_amplitude*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes12,'YLabel'),'String','|X(f)|','FontSize',12)
set(get(axes12,'Title'),'String','Frequency domain','FontSize',12)

axes13 = axes;
plot13 = plot(nan,'Parent',axes13);
set(axes13,'Units','pixels','Position',[2*gap,2*gap,samples_per_plot,small_plot_height],'YLim',[-pi*1.1,pi*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes13,'XLabel'),'String','f    [Hz]','FontSize',12)
set(get(axes13,'YLabel'),'String','arg[X(f)]','FontSize',12)
set(axes13,'YTick',[-pi;0;pi],'yticklabel',{'-p';'0';'p'},'fontname','symbol','XTick',get(axes12,'XTick'));

slider11 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_frequency,'Value',1,'Position',[2*gap,gap-15,samples_per_plot,10],'String','Frequency','ToolTip','Select the frequency of the first signal');
slider12 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_amplitude,'Value',1,'Position',[gap-15,small_plot_height+2.5*gap,10,small_plot_height],'ToolTip','Select the amplitude of the first signal');
slider13 = uicontrol('Style','slider','Units','pixels','Min',-0.999*pi,'Max',pi,'Value',0,'Position',[gap-15,2*gap,10,small_plot_height],'ToolTip','Select the phase of the first signal');






axes21 = axes;
plot21 = plot(nan,'Parent',axes21);
set(axes21,'Units','pixels','Position',[samples_per_plot+5*gap,2*small_plot_height+4.5*gap,samples_per_plot,big_plot_height],'YLim',[-max_amplitude*1.1,max_amplitude*1.1],'XLim',x_limits,'Box','on','FontSize',12);
set(get(axes21,'XLabel'),'String','t    [s]','FontSize',12)
set(get(axes21,'YLabel'),'String','y(t)','FontSize',12)
set(get(axes21,'Title'),'String','Time domain','FontSize',12)

axes22 = axes;
plot22 = plot(nan,'Parent',axes22);
set(axes22,'Units','pixels','Position',[samples_per_plot+5*gap,small_plot_height+2.5*gap,samples_per_plot,small_plot_height],'YLim',[-max_amplitude*0.1,max_amplitude*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes22,'YLabel'),'String','|Y(f)|','FontSize',12)
set(get(axes22,'Title'),'String','Frequency domain','FontSize',12)

axes23 = axes;
plot23 = plot(nan,'Parent',axes23);
set(axes23,'Units','pixels','Position',[samples_per_plot+5*gap,2*gap,samples_per_plot,small_plot_height],'YLim',[-pi*1.1,pi*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes23,'XLabel'),'String','f    [Hz]','FontSize',12)
set(get(axes23,'YLabel'),'String','arg[Y(f)]','FontSize',12)
set(axes23,'YTick',[-pi;0;pi],'yticklabel',{'-p';'0';'p'},'fontname','symbol','XTick',get(axes12,'XTick'));

slider21 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_frequency,'Value',2,'Position',[samples_per_plot+5*gap,gap-15,samples_per_plot,10],'String','Frequency','ToolTip','Select the frequency of the second signal');
slider22 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_amplitude,'Value',1,'Position',[samples_per_plot+4*gap-15,small_plot_height+2.5*gap,10,small_plot_height],'ToolTip','Select the amplitude of the second signal');
slider23 = uicontrol('Style','slider','Units','pixels','Min',-0.999*pi,'Max',pi,'Value',0,'Position',[samples_per_plot+4*gap-15,2*gap,10,small_plot_height],'ToolTip','Select the phase of the second signal');

lock_button = uicontrol('Style','togglebutton','Units','pixels','Position',[samples_per_plot+3.5*gap-50,gap-22.5,100,25],'String','Lock Freqs','Value',0,'FontSize',12,'ToolTip','Lock the frequency of the second signal onto that of the first signal');




axes31 = axes;
plot31 = plot(nan,'Parent',axes31);
set(axes31,'Units','pixels','Position',[2*samples_per_plot+8*gap,2*small_plot_height+4.5*gap,samples_per_plot,big_plot_height],'YLim',[-max_amplitude*1.1,max_amplitude*1.1],'XLim',x_limits,'Box','on','FontSize',12);
set(get(axes31,'XLabel'),'String','t    [s]','FontSize',12)
set(get(axes31,'YLabel'),'String','x(t)+y(t)','FontSize',12)
set(get(axes31,'Title'),'String','Time domain','FontSize',12)

axes32 = axes;
plot32 = plot(nan,'Parent',axes32);
set(axes32,'Units','pixels','Position',[2*samples_per_plot+8*gap,small_plot_height+2.5*gap,samples_per_plot,small_plot_height],'YLim',[-max_amplitude*0.1,max_amplitude*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes32,'YLabel'),'String','|X(f)+Y(f)|','FontSize',12)
set(get(axes32,'Title'),'String','Frequency domain','FontSize',12)

axes33 = axes;
plot33 = plot(nan,'Parent',axes33);
set(axes33,'Units','pixels','Position',[2*samples_per_plot+8*gap,2*gap,samples_per_plot,small_plot_height],'YLim',[-pi*1.1,pi*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes33,'XLabel'),'String','f    [Hz]','FontSize',12)
set(get(axes33,'YLabel'),'String','arg[X(f)+Y(f)]','FontSize',12)
set(axes33,'YTick',[-pi;0;pi],'yticklabel',{'-p';'0';'p'},'fontname','symbol','XTick',get(axes12,'XTick'));





data1 = [];
time = [];

data2 = [];


frame_index = 1;
sample_index = 0;
slider1_value = nan;

try
    while 1
        tic
        
        if get(pause_button,'Value') == 0
            
            if get(lock_button,'Value')
                set(slider21,'Visible','off');
                set(slider21,'Value',get(slider11,'Value'));
            else
                set(slider21,'Visible','on');
            end
            
            
            sample_count = round(frame_index*samples_per_frame)-sample_index;
            
            new_time = ((0:sample_count-1)+sample_index)*seconds_per_sample;
            
            frequency1 = get(slider11,'Value');
            amplitude1 = get(slider12,'Value');
            phase1 = get(slider13,'Value');
            
            frequency2 = get(slider21,'Value');
            amplitude2 = get(slider22,'Value');
            phase2 = get(slider23,'Value');
            
            
            new_data1 = amplitude1*cos(2*pi*frequency1*new_time + phase1);
            
            set(plot12,'XData',[0,frequency1,frequency1,frequency1,max_frequency*1.05]);
            set(plot12,'YData',[0,0,amplitude1,0,0]);
            
            set(plot13,'XData',[0,frequency1,frequency1,frequency1,max_frequency*1.05]);
            set(plot13,'YData',[0,0,phase1,0,0]);
            
            
            
            new_data2 = amplitude2*cos(2*pi*frequency2*new_time + phase2);
            
            set(plot22,'XData',[0,frequency2,frequency2,frequency2,max_frequency*1.05]);
            set(plot22,'YData',[0,0,amplitude2,0,0]);
            
            set(plot23,'XData',[0,frequency2,frequency2,frequency2,max_frequency*1.05]);
            set(plot23,'YData',[0,0,phase2,0,0]);
            
            
            if frequency1 == frequency2
                x1 = amplitude1*cos(phase1);
                y1 = amplitude1*sin(phase1);
                x2 = amplitude2*cos(phase2);
                y2 = amplitude2*sin(phase2);
                
                x = x1+x2;
                y = y1+y2;
                
                amplitude = sqrt(x^2+y^2);
                if x >= 0
                    phase = atan(y/x);
                else
                    phase = atan(y/x) - pi;
                end
                phase = mod(phase,2*pi);
                if phase > pi
                    phase = phase - 2*pi;
                end
                
                set(plot32,'XData',[0,frequency2,frequency2,frequency2,max_frequency*1.05]);
                set(plot32,'YData',[0,0,amplitude,0,0]);
                
                set(plot33,'XData',[0,frequency2,frequency2,frequency2,max_frequency*1.05]);
                set(plot33,'YData',[0,0,phase,0,0]);
                
            else
                if frequency1 < frequency2
                    lower_frequency = frequency1;
                    lower_amplitude = amplitude1;
                    lower_phase = phase1;
                    upper_frequency = frequency2;
                    upper_amplitude = amplitude2;
                    upper_phase = phase2;
                else
                    lower_frequency = frequency2;
                    lower_amplitude = amplitude2;
                    lower_phase = phase2;
                    upper_frequency = frequency1;
                    upper_amplitude = amplitude1;
                    upper_phase = phase1;
                end
                set(plot32,'XData',[0,lower_frequency,lower_frequency,lower_frequency,upper_frequency,upper_frequency,upper_frequency,max_frequency*1.05]);
                set(plot32,'YData',[0,0,lower_amplitude,0,0,upper_amplitude,0,0]);
                
                set(plot33,'XData',[0,lower_frequency,lower_frequency,lower_frequency,upper_frequency,upper_frequency,upper_frequency,max_frequency*1.05]);
                set(plot33,'YData',[0,0,lower_phase,0,0,upper_phase,0,0]);
            end
            
            old_time = time(max(1,length(time)-samples_per_plot+sample_count+1):end);
            old_data1 = data1(max(1,length(data1)-samples_per_plot+sample_count+1):end);
            old_data2 = data2(max(1,length(data2)-samples_per_plot+sample_count+1):end);
            
            time = [old_time,new_time];
            data1 = [old_data1,new_data1];
            data2 = [old_data2,new_data2];
            
            set(plot11,'XData',time);
            set(plot11,'YData',data1);
            set(axes11,'XLim',[time(1),max(time(end),seconds_per_plot)]);
            
            set(plot21,'XData',time);
            set(plot21,'YData',data2);
            set(axes21,'XLim',[time(1),max(time(end),seconds_per_plot)]);
            
            set(plot31,'XData',time);
            set(plot31,'YData',data1+data2);
            set(axes31,'XLim',[time(1),max(time(end),seconds_per_plot)]);
            
            sample_index = sample_index + sample_count;
            frame_index = frame_index + 1;
            
        end
        
        drawnow
        while toc < seconds_per_frame
        end
    end
end
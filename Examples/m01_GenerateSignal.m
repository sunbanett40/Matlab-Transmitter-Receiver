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

filter_order = 10*ceil(samples_per_second/min_frequency);
B = fir1(filter_order, 2*min_frequency/samples_per_second);
hd = dfilt.dffir(B);
hd.persistentmemory = true;
hd.state = randn(1,filter_order);



fig1 = figure('Units','pixels','Position',[0,0,samples_per_plot+4*gap,big_plot_height+2*small_plot_height+6.5*gap],'Resize','off','Name','Signal Generation','MenuBar','none');

pause_button = uicontrol('Style','togglebutton','Units','pixels','Position',[0.5*gap,big_plot_height+2*small_plot_height+5.5*gap-12.5,100,25],'String','Pause','Value',0,'FontSize',12,'ToolTip','Pause the simulation');

options = {'Cosine','Square','Sawtooth','Triangle','Impulses','Random'};
menu1 = uicontrol('Style','popupmenu','Units','pixels','Position',[2*gap+0.5*samples_per_plot-50,big_plot_height+2*small_plot_height+5.5*gap-12.5,100,25],'String',options,'FontSize',12,'ToolTip','Select the type of the signal');

menu2 = uicontrol('Style','popupmenu','Units','pixels','Position',[2.5*gap+samples_per_plot-50,big_plot_height+2*small_plot_height+5.5*gap-12.5,100,25],'String',{'1 term','2 terms','4 terms','8 terms','16 terms','32 terms','64 terms'},'Value',7,'FontSize',12,'ToolTip','Select the number of harmonics that are summed to create the signal');

x_limits = [0, seconds_per_plot];
axes1 = axes;
plot1 = plot(nan,'Parent',axes1);
set(axes1,'Units','pixels','Position',[2*gap,2*small_plot_height+4.5*gap,samples_per_plot,big_plot_height],'YLim',[-max_amplitude*1.1,max_amplitude*1.1],'XLim',x_limits,'Box','on','FontSize',12);
set(get(axes1,'XLabel'),'String','t    [s]','FontSize',12)
set(get(axes1,'YLabel'),'String','x(t)','FontSize',12)
set(get(axes1,'Title'),'String','Time domain','FontSize',12)

axes2 = axes;
plot2 = plot(nan,'Parent',axes2);
set(axes2,'Units','pixels','Position',[2*gap,small_plot_height+2.5*gap,samples_per_plot,small_plot_height],'YLim',[-max_amplitude*0.1,max_amplitude*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12);
set(get(axes2,'YLabel'),'String','|X(f)|','FontSize',12)
set(get(axes2,'Title'),'String','Frequency domain','FontSize',12)

axes3 = axes;
plot3 = plot(nan,'Parent',axes3);
set(axes3,'Units','pixels','Position',[2*gap,2*gap,samples_per_plot,small_plot_height],'YLim',[-pi*1.1,pi*1.1],'XLim',[-max_frequency*0.05,max_frequency*1.05],'Box','on','FontSize',12); % Rob
set(get(axes3,'XLabel'),'String','f    [Hz]','FontSize',12)
set(get(axes3,'YLabel'),'String','arg[X(f)]','FontSize',12)
set(axes3,'YTick',[-pi;0;pi],'yticklabel',{'-p';'0';'p'},'fontname','symbol','XTick',get(axes2,'XTick')); % Rob



slider1 = uicontrol('Style','slider','Units','pixels','Min',min_frequency,'Max',max_frequency,'Value',1,'Position',[2*gap,gap-15,samples_per_plot,10],'String','Frequency','ToolTip','Select the (fundamental/maximum) frequency of the signal');
slider2 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_amplitude,'Value',1,'Position',[gap-15,small_plot_height+2.5*gap,10,small_plot_height],'ToolTip','Select the amplitude of the signal');
slider3 = uicontrol('Style','slider','Units','pixels','Min',-0.999*pi,'Max',pi,'Value',0,'Position',[gap-15,2*gap,10,small_plot_height],'ToolTip','Select the phase of the signal'); % Rob
slider4 = uicontrol('Style','slider','Units','pixels','Min',0,'Max',max_amplitude,'Value',0,'Position',[0.5*gap-15,small_plot_height+2.5*gap,10,small_plot_height],'ToolTip','Select the DC offset of the signal');


data = [];
time = [];

frame_index = 1;
sample_index = 0;
slider1_value = nan;

try
    while 1
        tic
        
        
        
        if get(pause_button,'Value') == 0
            
            sample_count = round(frame_index*samples_per_frame)-sample_index;
            
            new_time = ((0:sample_count-1)+sample_index)*seconds_per_sample;
            %    new_data = randn(1,sample_count);
            
            frequency = get(slider1,'Value');
            amplitude = get(slider2,'Value');
            phase = get(slider3,'Value');
            dc_offset = get(slider4,'Value');
            
            
            
            if isequal(options{get(menu1,'Value')},'Cosine')
                set(slider3,'Visible','on');
                set(menu2,'Visible','off');
                
                new_data = amplitude*cos(2*pi*frequency*new_time + phase)+dc_offset;
                
                set(plot2,'XData',[0,0,frequency,frequency,frequency,max_frequency*1.05]);
                set(plot2,'YData',[dc_offset,0,0,amplitude,0,0]);
                
                set(plot3,'XData',[0,frequency,frequency,frequency,max_frequency*1.05]);
                set(plot3,'YData',[0,0,phase,0,0]);
                
            elseif isequal(options{get(menu1,'Value')},'Square')
                set(slider3,'Visible','on');
                set(menu2,'Visible','on');
                
                
                new_data = dc_offset*ones(size(new_time));
                frequencies = [0,0];
                amplitudes = [dc_offset,0];
                phases = [0,0];
                
                
                for n = 1:2^(get(menu2,'Value')-1)
                    if mod(n,2) == 1
                        new_data = new_data + amplitude*4/pi/n*cos(2*pi*n*frequency*new_time+pi/2*(n-1)+n*phase);
                        
                        frequencies = [frequencies,n*frequency,n*frequency,n*frequency];
                        amplitudes = [amplitudes,0,amplitude*4/pi/n,0];
                        phases = [phases,0,pi/2*(n-1)+n*phase,0];
                    end
                end
                
                
                frequencies = [frequencies,max_frequency*1.05];
                amplitudes = [amplitudes,0];
                phases = [phases,0];
                phases = mod(phases,2*pi);
                phases(phases > pi) = phases(phases > pi)-2*pi; % Rob
                
                set(plot2,'XData',frequencies);
                set(plot2,'YData',amplitudes);
                
                set(plot3,'XData',frequencies);
                set(plot3,'YData',phases);
                
                
            elseif isequal(options{get(menu1,'Value')},'Triangle')
                set(slider3,'Visible','on');
                set(menu2,'Visible','on');
                new_data = dc_offset*ones(size(new_time));
                frequencies = [0,0];
                amplitudes = [dc_offset,0];
                phases = [0,0];
                
                for n = 1:2^(get(menu2,'Value')-1)
                    if mod(n,2) == 1
                        new_data = new_data + amplitude*8/pi^2/n^2*cos(2*pi*n*frequency*new_time+n*phase);
                        
                        frequencies = [frequencies,n*frequency,n*frequency,n*frequency];
                        amplitudes = [amplitudes,0,amplitude*8/pi^2/n^2,0];
                        phases = [phases,0,n*phase,0];
                    end
                    
                end
                
                frequencies = [frequencies,max_frequency*1.05];
                amplitudes = [amplitudes,0];
                phases = [phases,0];
                phases = mod(phases,2*pi);
                phases(phases > pi) = phases(phases > pi)-2*pi; % Rob
                
                set(plot2,'XData',frequencies);
                set(plot2,'YData',amplitudes);
                
                set(plot3,'XData',frequencies);
                set(plot3,'YData',phases);
                
                
                
            elseif isequal(options{get(menu1,'Value')},'Sawtooth')
                set(slider3,'Visible','on');
                set(menu2,'Visible','on');
                
                
                new_data = dc_offset*ones(size(new_time));
                frequencies = [0,0];
                amplitudes = [dc_offset,0];
                phases = [0,0];
                
                for n = 1:2^(get(menu2,'Value')-1)
                    new_data = new_data + 2*amplitude/pi/n*cos(2*pi*n*frequency*new_time+pi/2*(1-n)+n*phase);
                    
                    frequencies = [frequencies,n*frequency,n*frequency,n*frequency];
                    amplitudes = [amplitudes,0,2*amplitude/pi/n,0];
                    phases = [phases,0,pi/2*(1-n)+n*phase,0];
                end
                
                frequencies = [frequencies,max_frequency*1.05];
                amplitudes = [amplitudes,0];
                phases = [phases,0];
                phases = mod(phases,2*pi);
                phases(phases > pi) = phases(phases > pi)-2*pi; % Rob
                
                set(plot2,'XData',frequencies);
                set(plot2,'YData',amplitudes);
                
                set(plot3,'XData',frequencies);
                set(plot3,'YData',phases);
                
                
            elseif isequal(options{get(menu1,'Value')},'Impulses')
                set(slider3,'Visible','on');
                set(menu2,'Visible','on');
                
                terms = 2^(get(menu2,'Value')-1);
                new_data = (amplitude/(1+2*terms)+dc_offset)*ones(size(new_time));
                
                frequencies = [0,0];
                amplitudes = [amplitude+dc_offset,0];
                phases = [0,0];
                
                
                
                for n = 1:terms
                    new_data = new_data + 2*amplitude/(1+2*terms)*cos(2*pi*n*frequency*new_time+n*phase);
                     
                    frequencies = [frequencies,n*frequency,n*frequency,n*frequency];
                    amplitudes = [amplitudes,0,2*amplitude,0];
                    phases = [phases,0,n*phase,0];
                end
                
                frequencies = [frequencies,max_frequency*1.05];
                amplitudes = [amplitudes,0];
                phases = [phases,0];
                phases = mod(phases,2*pi);
                phases(phases > pi) = phases(phases > pi)-2*pi; % Rob
                
                set(plot2,'XData',frequencies);
                set(plot2,'YData',amplitudes);
                
                set(plot3,'XData',frequencies);
                set(plot3,'YData',phases);
                
                
            elseif isequal(options{get(menu1,'Value')},'Random')
                set(slider3,'Visible','off');
                set(menu2,'Visible','off');
                
                
                if get(slider1,'Value') ~= slider1_value
                    slider1_value = get(slider1,'Value');
                    B = fir1(filter_order, 2*frequency/samples_per_second);
                    temp_state = hd.state;
                    hd = dfilt.dffir(B);
                    hd.persistentmemory = true;
                    hd.state = temp_state;
                end
                
                new_data = randn(size(new_time));
                new_data = amplitude*filter(hd,new_data)+dc_offset;
                set(plot2,'XData',[0,0,frequency,frequency,max_frequency*1.05]);
                set(plot2,'YData',[dc_offset,amplitude,amplitude,0,0]);
                
                
                set(plot3,'XData',[frequency,frequency,0,0,frequency,frequency,max_frequency*1.05]); % Rob
                set(plot3,'YData',[0,pi,pi,-pi,-pi,0,0]); % Rob
                
                
                
                
            end
            
            old_time = time(max(1,length(time)-samples_per_plot+sample_count+1):end);
            old_data = data(max(1,length(data)-samples_per_plot+sample_count+1):end);
            
            time = [old_time,new_time];
            data = [old_data,new_data];
            
            set(plot1,'XData',time);
            set(plot1,'YData',data);
            set(axes1,'XLim',[time(1),max(time(end),seconds_per_plot)]);
            
            
            
            sample_index = sample_index + sample_count;
            frame_index = frame_index + 1;
            
        end
        
        drawnow
        while toc < seconds_per_frame
        end
    end
end
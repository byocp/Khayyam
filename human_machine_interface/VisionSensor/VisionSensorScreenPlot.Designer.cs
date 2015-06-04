namespace VisionSensor {
    partial class VisionSensorScreenPlot {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if(disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent() {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea2 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend2 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series2 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.label8 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.great3 = new System.Windows.Forms.TextBox();
            this.great2 = new System.Windows.Forms.TextBox();
            this.great1 = new System.Windows.Forms.TextBox();
            this.exit_btn = new System.Windows.Forms.Button();
            this.memUsed = new System.Windows.Forms.TextBox();
            this.memAvailable = new System.Windows.Forms.TextBox();
            this.particles_per_L = new System.Windows.Forms.TextBox();
            this.Pic_num = new System.Windows.Forms.TextBox();
            this.Return_KexC = new System.Windows.Forms.Button();
            this.Start_btn = new System.Windows.Forms.Button();
            this.RefreshMatlab = new System.Windows.Forms.Timer(this.components);
            this.particles = new System.Windows.Forms.TextBox();
            this.proc_img = new System.Windows.Forms.PictureBox();
            this.raw_img = new System.Windows.Forms.PictureBox();
            this.Scroll_pics = new System.Windows.Forms.HScrollBar();
            this.stopBtn = new System.Windows.Forms.Button();
            this.label9 = new System.Windows.Forms.Label();
            this.g_per_L = new System.Windows.Forms.TextBox();
            this.plotHist = new System.Windows.Forms.Button();
            this.time = new System.Windows.Forms.TextBox();
            this.label10 = new System.Windows.Forms.Label();
            this.hist_plot = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.plotGrams = new System.Windows.Forms.Button();
            this.grams_plot = new System.Windows.Forms.DataVisualization.Charting.Chart();
            ((System.ComponentModel.ISupportInitialize)(this.proc_img)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.raw_img)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.hist_plot)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.grams_plot)).BeginInit();
            this.SuspendLayout();
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(18, 289);
            this.label8.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(47, 13);
            this.label8.TabIndex = 46;
            this.label8.Text = "Picture#";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(628, 308);
            this.label7.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(58, 13);
            this.label7.TabIndex = 45;
            this.label7.Text = "Particles/L";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(597, 284);
            this.label6.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(94, 13);
            this.label6.TabIndex = 44;
            this.label6.Text = "TotalParticleCount";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(628, 399);
            this.label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(72, 13);
            this.label5.TabIndex = 43;
            this.label5.Text = "Memory Used";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(589, 375);
            this.label4.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(111, 13);
            this.label4.TabIndex = 42;
            this.label4.Text = "TotalMemoryAvailable";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(18, 426);
            this.label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(93, 13);
            this.label3.TabIndex = 41;
            this.label3.Text = "Particles > 1.0 mm";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(18, 393);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(93, 13);
            this.label2.TabIndex = 40;
            this.label2.Text = "Particles > 0.4 mm";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(18, 362);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(93, 13);
            this.label1.TabIndex = 39;
            this.label1.Text = "Particles > 0.1 mm";
            // 
            // great3
            // 
            this.great3.Location = new System.Drawing.Point(116, 423);
            this.great3.Name = "great3";
            this.great3.Size = new System.Drawing.Size(74, 20);
            this.great3.TabIndex = 38;
            // 
            // great2
            // 
            this.great2.Location = new System.Drawing.Point(116, 391);
            this.great2.Name = "great2";
            this.great2.Size = new System.Drawing.Size(74, 20);
            this.great2.TabIndex = 37;
            // 
            // great1
            // 
            this.great1.Location = new System.Drawing.Point(116, 359);
            this.great1.Name = "great1";
            this.great1.Size = new System.Drawing.Size(74, 20);
            this.great1.TabIndex = 36;
            // 
            // exit_btn
            // 
            this.exit_btn.BackColor = System.Drawing.SystemColors.Control;
            this.exit_btn.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.exit_btn.Location = new System.Drawing.Point(484, 273);
            this.exit_btn.Name = "exit_btn";
            this.exit_btn.Size = new System.Drawing.Size(93, 36);
            this.exit_btn.TabIndex = 35;
            this.exit_btn.Text = "Exit";
            this.exit_btn.UseVisualStyleBackColor = false;
            this.exit_btn.Click += new System.EventHandler(this.exit_btn_Click_1);
            // 
            // memUsed
            // 
            this.memUsed.Location = new System.Drawing.Point(704, 396);
            this.memUsed.Name = "memUsed";
            this.memUsed.Size = new System.Drawing.Size(65, 20);
            this.memUsed.TabIndex = 33;
            // 
            // memAvailable
            // 
            this.memAvailable.Location = new System.Drawing.Point(704, 372);
            this.memAvailable.Name = "memAvailable";
            this.memAvailable.Size = new System.Drawing.Size(65, 20);
            this.memAvailable.TabIndex = 32;
            // 
            // particles_per_L
            // 
            this.particles_per_L.Location = new System.Drawing.Point(695, 306);
            this.particles_per_L.Name = "particles_per_L";
            this.particles_per_L.Size = new System.Drawing.Size(74, 20);
            this.particles_per_L.TabIndex = 31;
            // 
            // Pic_num
            // 
            this.Pic_num.Location = new System.Drawing.Point(77, 287);
            this.Pic_num.Name = "Pic_num";
            this.Pic_num.Size = new System.Drawing.Size(74, 20);
            this.Pic_num.TabIndex = 30;
            // 
            // Return_KexC
            // 
            this.Return_KexC.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.Return_KexC.Location = new System.Drawing.Point(284, 273);
            this.Return_KexC.Name = "Return_KexC";
            this.Return_KexC.Size = new System.Drawing.Size(177, 36);
            this.Return_KexC.TabIndex = 29;
            this.Return_KexC.Text = "Back to Kex-C";
            this.Return_KexC.UseVisualStyleBackColor = true;
            this.Return_KexC.Click += new System.EventHandler(this.Return_KexC_Click);
            // 
            // Start_btn
            // 
            this.Start_btn.BackColor = System.Drawing.SystemColors.Control;
            this.Start_btn.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.Start_btn.Location = new System.Drawing.Point(170, 273);
            this.Start_btn.Name = "Start_btn";
            this.Start_btn.Size = new System.Drawing.Size(93, 36);
            this.Start_btn.TabIndex = 28;
            this.Start_btn.Text = "Start";
            this.Start_btn.UseVisualStyleBackColor = false;
            this.Start_btn.Click += new System.EventHandler(this.Start_btn_Click);
            // 
            // RefreshMatlab
            // 
            this.RefreshMatlab.Enabled = true;
            this.RefreshMatlab.Tick += new System.EventHandler(this.RefreshMatlab_Tick);
            // 
            // particles
            // 
            this.particles.Location = new System.Drawing.Point(695, 281);
            this.particles.Name = "particles";
            this.particles.Size = new System.Drawing.Size(74, 20);
            this.particles.TabIndex = 34;
            // 
            // proc_img
            // 
            this.proc_img.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.proc_img.Location = new System.Drawing.Point(398, 15);
            this.proc_img.Name = "proc_img";
            this.proc_img.Size = new System.Drawing.Size(370, 245);
            this.proc_img.TabIndex = 27;
            this.proc_img.TabStop = false;
            this.proc_img.Click += new System.EventHandler(this.proc_img_Click);
            // 
            // raw_img
            // 
            this.raw_img.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.raw_img.Location = new System.Drawing.Point(10, 15);
            this.raw_img.Name = "raw_img";
            this.raw_img.Size = new System.Drawing.Size(369, 245);
            this.raw_img.TabIndex = 26;
            this.raw_img.TabStop = false;
            // 
            // Scroll_pics
            // 
            this.Scroll_pics.Location = new System.Drawing.Point(200, 327);
            this.Scroll_pics.Maximum = 10;
            this.Scroll_pics.Name = "Scroll_pics";
            this.Scroll_pics.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.Scroll_pics.Size = new System.Drawing.Size(409, 40);
            this.Scroll_pics.TabIndex = 25;
            // 
            // stopBtn
            // 
            this.stopBtn.BackColor = System.Drawing.SystemColors.Control;
            this.stopBtn.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.stopBtn.Location = new System.Drawing.Point(338, 383);
            this.stopBtn.Name = "stopBtn";
            this.stopBtn.Size = new System.Drawing.Size(93, 36);
            this.stopBtn.TabIndex = 47;
            this.stopBtn.Text = "Stop";
            this.stopBtn.UseVisualStyleBackColor = false;
            this.stopBtn.Click += new System.EventHandler(this.stopBtn_Click);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(662, 337);
            this.label9.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(24, 13);
            this.label9.TabIndex = 48;
            this.label9.Text = "g/L";
            // 
            // g_per_L
            // 
            this.g_per_L.Location = new System.Drawing.Point(695, 335);
            this.g_per_L.Name = "g_per_L";
            this.g_per_L.Size = new System.Drawing.Size(74, 20);
            this.g_per_L.TabIndex = 49;
            // 
            // plotHist
            // 
            this.plotHist.BackColor = System.Drawing.SystemColors.Control;
            this.plotHist.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.plotHist.Location = new System.Drawing.Point(591, 666);
            this.plotHist.Name = "plotHist";
            this.plotHist.Size = new System.Drawing.Size(112, 36);
            this.plotHist.TabIndex = 53;
            this.plotHist.Text = "PlotHist";
            this.plotHist.UseVisualStyleBackColor = false;
            this.plotHist.Click += new System.EventHandler(this.plotHist_Click);
            // 
            // time
            // 
            this.time.Location = new System.Drawing.Point(630, 635);
            this.time.Name = "time";
            this.time.Size = new System.Drawing.Size(74, 20);
            this.time.TabIndex = 54;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(589, 637);
            this.label10.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(30, 13);
            this.label10.TabIndex = 55;
            this.label10.Text = "Time";
            // 
            // hist_plot
            // 
            chartArea1.Name = "ChartArea1";
            this.hist_plot.ChartAreas.Add(chartArea1);
            legend1.Name = "Legend1";
            this.hist_plot.Legends.Add(legend1);
            this.hist_plot.Location = new System.Drawing.Point(756, 461);
            this.hist_plot.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.hist_plot.Name = "hist_plot";
            series1.ChartArea = "ChartArea1";
            series1.Legend = "Legend1";
            series1.Name = "particleDist";
            this.hist_plot.Series.Add(series1);
            this.hist_plot.Size = new System.Drawing.Size(514, 326);
            this.hist_plot.TabIndex = 56;
            this.hist_plot.Text = "chart1";
            // 
            // plotGrams
            // 
            this.plotGrams.BackColor = System.Drawing.SystemColors.Control;
            this.plotGrams.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.plotGrams.Location = new System.Drawing.Point(591, 469);
            this.plotGrams.Name = "plotGrams";
            this.plotGrams.Size = new System.Drawing.Size(112, 36);
            this.plotGrams.TabIndex = 57;
            this.plotGrams.Text = "PlotGraph";
            this.plotGrams.UseVisualStyleBackColor = false;
            this.plotGrams.Click += new System.EventHandler(this.plotGrams_Click);
            // 
            // grams_plot
            // 
            chartArea2.Name = "ChartArea1";
            this.grams_plot.ChartAreas.Add(chartArea2);
            legend2.Name = "Legend1";
            this.grams_plot.Legends.Add(legend2);
            this.grams_plot.Location = new System.Drawing.Point(20, 461);
            this.grams_plot.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.grams_plot.Name = "grams_plot";
            series2.ChartArea = "ChartArea1";
            series2.Legend = "Legend1";
            series2.Name = "particleDist";
            this.grams_plot.Series.Add(series2);
            this.grams_plot.Size = new System.Drawing.Size(514, 326);
            this.grams_plot.TabIndex = 58;
            this.grams_plot.Text = "chart1";
            // 
            // VisionSensorScreenPlot
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1191, 703);
            this.Controls.Add(this.grams_plot);
            this.Controls.Add(this.plotGrams);
            this.Controls.Add(this.hist_plot);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.time);
            this.Controls.Add(this.plotHist);
            this.Controls.Add(this.g_per_L);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.stopBtn);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.great3);
            this.Controls.Add(this.great2);
            this.Controls.Add(this.great1);
            this.Controls.Add(this.exit_btn);
            this.Controls.Add(this.memUsed);
            this.Controls.Add(this.memAvailable);
            this.Controls.Add(this.particles_per_L);
            this.Controls.Add(this.Pic_num);
            this.Controls.Add(this.Return_KexC);
            this.Controls.Add(this.Start_btn);
            this.Controls.Add(this.particles);
            this.Controls.Add(this.proc_img);
            this.Controls.Add(this.raw_img);
            this.Controls.Add(this.Scroll_pics);
            this.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Name = "VisionSensorScreenPlot";
            this.Text = "VisionSensorScreenPlot";
            this.Load += new System.EventHandler(this.VisionSensorScreen_Load_1);
            ((System.ComponentModel.ISupportInitialize)(this.proc_img)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.raw_img)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.hist_plot)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.grams_plot)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox great3;
        private System.Windows.Forms.TextBox great2;
        private System.Windows.Forms.TextBox great1;
        private System.Windows.Forms.Button exit_btn;
        private System.Windows.Forms.TextBox memUsed;
        private System.Windows.Forms.TextBox memAvailable;
        private System.Windows.Forms.TextBox particles_per_L;
        private System.Windows.Forms.TextBox Pic_num;
        private System.Windows.Forms.Button Return_KexC;
        private System.Windows.Forms.Button Start_btn;
        private System.Windows.Forms.Timer RefreshMatlab;
        private System.Windows.Forms.TextBox particles;
        private System.Windows.Forms.PictureBox proc_img;
        private System.Windows.Forms.PictureBox raw_img;
        private System.Windows.Forms.HScrollBar Scroll_pics;
        private System.Windows.Forms.Button stopBtn;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox g_per_L;
        private System.Windows.Forms.Button plotHist;
        private System.Windows.Forms.TextBox time;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.DataVisualization.Charting.Chart hist_plot;
        private System.Windows.Forms.Button plotGrams;
        private System.Windows.Forms.DataVisualization.Charting.Chart grams_plot;
    }
}


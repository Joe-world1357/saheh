import svgPaths from "./svg-aex1tdwrsk";
import imgChatGptImageNov212025033336PmRemovebgPreview2 from "figma:asset/ca93a485f03f444bb8af25d70d6a69eb0c3a8497.png";
import imgWhatsAppImage20251217At112148PmRemovebgPreview1 from "figma:asset/2116d541503288813a87ecce1a7ae2f3df51b1fa.png";

function Group() {
  return (
    <div className="absolute contents left-[35px] top-[813px]">
      <div className="absolute inset-[88.66%_8.01%_5.13%_8.5%]">
        <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 344 57">
          <path d={svgPaths.p3d587400} fill="var(--fill-0, #20C6B7)" id="Rectangle 173" />
        </svg>
      </div>
      <p className="absolute font-['Montserrat_Alternates:SemiBold',sans-serif] h-[36px] leading-[normal] left-[calc(50%+1px)] not-italic text-[20px] text-center text-white top-[calc(50%+365.5px)] translate-x-[-50%] w-[240px]">Get Started</p>
    </div>
  );
}

export default function Welcome() {
  return (
    <div className="bg-[#f5fafa] relative size-full" data-name="Welcome">
      <p className="absolute font-['Paytone_One:Regular',sans-serif] h-[100px] leading-[normal] left-[calc(50%-0.5px)] not-italic text-[#1a2a2c] text-[36px] text-center top-[597px] translate-x-[-50%] w-[347px]">Your health journey starts here</p>
      <Group />
      <div className="absolute left-[-19px] size-[471px] top-[42px]" data-name="ChatGPT_Image_Nov_21__2025__03_33_36_PM-removebg-preview 2">
        <img alt="" className="absolute inset-0 max-w-none object-50%-50% object-cover pointer-events-none size-full" src={imgChatGptImageNov212025033336PmRemovebgPreview2} />
      </div>
      <div className="absolute h-[407px] left-[-100px] top-[240px] w-[612px]" data-name="WhatsApp_Image_2025-12-17_at_11.21.48_PM-removebg-preview 1">
        <img alt="" className="absolute inset-0 max-w-none object-50%-50% object-cover pointer-events-none size-full" src={imgWhatsAppImage20251217At112148PmRemovebgPreview1} />
      </div>
    </div>
  );
}